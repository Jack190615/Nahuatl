// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

/// Script de utilidad para convertir archivos CSV (exportados desde Excel)
/// a archivos JSON compatibles con Drift y la arquitectura de la app.
///
/// Uso:
///   dart run scripts/csv_to_json.dart
///   dart run scripts/csv_to_json.dart --input=assets/csv --output=assets/data
void main(List<String> args) {
  final inputDirArg = _getNamedArg(args, '--input') ?? 'assets/csv';
  final outputDirArg = _getNamedArg(args, '--output') ?? 'assets/data';

  final inputDir = Directory(inputDirArg);
  final outputDir = Directory(outputDirArg);

  if (!inputDir.existsSync()) {
    print('Creando directorio de entrada: ${inputDir.path}');
    inputDir.createSync(recursive: true);
  }

  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  print('======================================================');
  print('  Convertidor CSV -> JSON (Axolot\'s Studios)');
  print('======================================================');
  print('Directorio de origen (CSVs): ${inputDir.path}');
  print('Directorio de destino (JSONs): ${outputDir.path}\n');

  final converter = CsvToJsonConverter();
  final results = converter.convertDirectory(inputDir: inputDir, outputDir: outputDir);

  print('\nResumen de conversion:');
  for (final entry in results.entries) {
    print('  - ${entry.key}: ${entry.value} registros generados.');
  }

  print('\nProceso completado con exito.');
}

String? _getNamedArg(List<String> args, String prefix) {
  for (final arg in args) {
    if (arg.startsWith('$prefix=')) {
      return arg.substring(prefix.length + 1).trim();
    }
  }
  return null;
}

class CsvToJsonConverter {
  /// Convierte los 4 CSVs estandar si existen en [inputDir] y genera el seed unificado
  Map<String, int> convertDirectory({
    required Directory inputDir,
    required Directory outputDir,
  }) {
    final Map<String, int> counts = {};
    final Map<String, List<Map<String, dynamic>>> seedBundle = {
      'lessons': [],
      'grammar_rules': [],
      'dictionary': [],
      'phrases': [],
    };

    final schemas = {
      'lessons': (
        aliases: ['lessons.csv', 'lecciones.csv', 'Lecciones.csv', 'Lessons.csv'],
        transformer: _transformLessonRow,
      ),
      'grammar_rules': (
        aliases: ['grammar_rules.csv', 'reglas_gramaticales.csv', 'Reglas_Gramaticales.csv', 'reglas.csv', 'Reglas.csv', 'Grammar_Rules.csv'],
        transformer: _transformGrammarRuleRow,
      ),
      'dictionary': (
        aliases: ['dictionary.csv', 'diccionario.csv', 'Diccionario.csv', 'Dictionary.csv'],
        transformer: _transformDictionaryRow,
      ),
      'phrases': (
        aliases: ['phrases.csv', 'frases.csv', 'Frases.csv', 'Phrases.csv'],
        transformer: _transformPhraseRow,
      ),
    };

    for (final entry in schemas.entries) {
      final tableName = entry.key;
      final aliases = entry.value.aliases;
      final transformer = entry.value.transformer;

      File? foundFile;
      for (final alias in aliases) {
        final candidate = File('${inputDir.path}/$alias');
        if (candidate.existsSync()) {
          foundFile = candidate;
          break;
        }
      }

      if (foundFile != null) {
        final rows = convertFile(foundFile, transformer);
        final jsonFile = File('${outputDir.path}/$tableName.json');
        
        const encoder = JsonEncoder.withIndent('  ');
        jsonFile.writeAsStringSync('${encoder.convert(rows)}\n', encoding: utf8);

        counts[tableName] = rows.length;
        seedBundle[tableName] = rows;
        print('✓ [${foundFile.path.split(Platform.pathSeparator).last}] -> [$tableName.json] (${rows.length} filas)');
      } else {
        print('! [${aliases.first}] no encontrado en ${inputDir.path}.');
      }
    }

    // Si al menos una coleccion fue procesada, actualizar o generar initial_seed.json
    final totalRows = counts.values.fold<int>(0, (sum, count) => sum + count);
    if (totalRows > 0) {
      final seedFile = File('${outputDir.path}/initial_seed.json');
      const encoder = JsonEncoder.withIndent('  ');
      seedFile.writeAsStringSync('${encoder.convert(seedBundle)}\n', encoding: utf8);
      print('✓ [initial_seed.json] actualizado con los 4 conjuntos de datos.');
    }

    return counts;
  }

  /// Lee un archivo CSV (soportando UTF-8 con o sin BOM, comas o punto y coma de Excel)
  /// y aplica el [transformer] a cada fila.
  List<Map<String, dynamic>> convertFile(
    File file,
    Map<String, dynamic> Function(Map<String, String> row, int index) transformer,
  ) {
    final content = _readFileWithoutBom(file);
    final rawRows = parseCsvString(content);

    if (rawRows.isEmpty) return [];

    // Normalizar encabezados (a minusculas, trim)
    final headers = rawRows.first.map((h) => _normalizeHeader(h)).toList();
    final List<Map<String, dynamic>> results = [];

    for (int i = 1; i < rawRows.length; i++) {
      final rawRow = rawRows[i];
      if (rawRow.isEmpty || (rawRow.length == 1 && rawRow.first.trim().isEmpty)) {
        continue; // Ignorar lineas en blanco
      }

      final Map<String, String> rowMap = {};
      for (int h = 0; h < headers.length; h++) {
        final key = headers[h];
        final value = h < rawRow.length ? rawRow[h].trim() : '';
        rowMap[key] = value;
      }

      final transformed = transformer(rowMap, results.length + 1);
      results.add(transformed);
    }

    return results;
  }

  /// Parser RFC 4180 con deteccion automatica de delimitador (coma o punto y coma)
  List<List<String>> parseCsvString(String csvText) {
    if (csvText.trim().isEmpty) return [];

    final delimiter = _detectDelimiter(csvText);
    final List<List<String>> lines = [];
    List<String> currentRow = [];
    final StringBuffer currentField = StringBuffer();

    bool inQuotes = false;
    final int length = csvText.length;

    for (int i = 0; i < length; i++) {
      final char = csvText[i];

      if (char == '"') {
        if (inQuotes && i + 1 < length && csvText[i + 1] == '"') {
          // Comillas escapadas ("") dentro de comillas
          currentField.write('"');
          i++;
        } else {
          inQuotes = !inQuotes;
        }
      } else if (char == delimiter && !inQuotes) {
        currentRow.add(currentField.toString());
        currentField.clear();
      } else if ((char == '\n' || char == '\r') && !inQuotes) {
        if (char == '\r' && i + 1 < length && csvText[i + 1] == '\n') {
          i++; // Manejo de CRLF (\r\n) de Windows/Excel
        }
        currentRow.add(currentField.toString());
        currentField.clear();
        lines.add(currentRow);
        currentRow = [];
      } else {
        currentField.write(char);
      }
    }

    if (currentField.isNotEmpty || currentRow.isNotEmpty) {
      currentRow.add(currentField.toString());
      lines.add(currentRow);
    }

    return lines;
  }

  String _readFileWithoutBom(File file) {
    final bytes = file.readAsBytesSync();
    // Detectar y omitir Byte Order Mark (BOM) UTF-8 (EF BB BF) que Excel suele agregar
    if (bytes.length >= 3 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF) {
      return utf8.decode(bytes.sublist(3));
    }
    return utf8.decode(bytes, allowMalformed: true);
  }

  String _detectDelimiter(String text) {
    // Tomar las primeras 3 lineas para detectar si predomina coma o punto y coma
    final sample = text.split(RegExp(r'[\r\n]+')).take(3).join('\n');
    final semicolons = RegExp(r';').allMatches(sample).length;
    final commas = RegExp(r',').allMatches(sample).length;
    return semicolons > commas ? ';' : ',';
  }

  String _normalizeHeader(String header) {
    return header
        .toLowerCase()
        .replaceAll(RegExp(r'[\s\-]+'), '_')
        .replaceAll(RegExp(r'[^a-z0-9_]'), '')
        .trim();
  }

  // ===========================================================================
  // TRANSFORMADORES ESPECIFICOS POR TABLA
  // ===========================================================================

  static Map<String, dynamic> _transformLessonRow(Map<String, String> row, int fallbackIndex) {
    final id = _parseInt(row['id'] ?? row['lesson_id'], fallbackIndex);
    final title = row['title'] ?? row['titulo'] ?? 'Leccion $id';
    final orderIndex = _parseInt(row['order_index'] ?? row['orden'] ?? row['index'], id);
    final isUnlocked = _parseBool(row['is_unlocked'] ?? row['desbloqueada'] ?? row['unlocked'], fallback: id == 1);

    return {
      'id': id,
      'title': title,
      'order_index': orderIndex,
      'is_unlocked': isUnlocked,
    };
  }

  static Map<String, dynamic> _transformGrammarRuleRow(Map<String, String> row, int fallbackIndex) {
    final id = _parseInt(row['id'], fallbackIndex);
    final lessonId = _parseInt(row['lesson_id'] ?? row['leccion_id'] ?? row['lesson'], 1);
    final explanationText = row['explanation_text'] ?? row['explicacion'] ?? row['texto'] ?? '';

    return {
      'id': id,
      'lesson_id': lessonId,
      'explanation_text': explanationText,
    };
  }

  static Map<String, dynamic> _transformDictionaryRow(Map<String, String> row, int fallbackIndex) {
    final id = _parseInt(row['id'], fallbackIndex);
    final nahuatlWord = row['nahuatl_word'] ?? row['palabra_nahuatl'] ?? row['nahuatl'] ?? '';
    final spanishTranslation = row['spanish_translation'] ?? row['traduccion_espanol'] ?? row['espanol'] ?? row['spanish'] ?? '';
    final wordType = (row['word_type'] ?? row['tipo'] ?? row['categoria'] ?? 'sustantivo').toLowerCase();
    final audioPath = _parseNullableString(row['audio_path'] ?? row['audio'] ?? row['ruta_audio']);

    return {
      'id': id,
      'nahuatl_word': nahuatlWord,
      'spanish_translation': spanishTranslation,
      'word_type': wordType,
      'audio_path': audioPath,
    };
  }

  static Map<String, dynamic> _transformPhraseRow(Map<String, String> row, int fallbackIndex) {
    final id = _parseInt(row['id'], fallbackIndex);
    final lessonId = _parseInt(row['lesson_id'] ?? row['leccion_id'] ?? row['lesson'], 1);
    final grammarRuleId = _parseNullableInt(row['grammar_rule_id'] ?? row['regla_id'] ?? row['regla']);
    final nahuatlSentence = row['nahuatl_sentence'] ?? row['oracion_nahuatl'] ?? row['nahuatl'] ?? '';
    final spanishTranslation = row['spanish_translation'] ?? row['traduccion_espanol'] ?? row['espanol'] ?? row['spanish'] ?? '';
    final audioPath = _parseNullableString(row['audio_path'] ?? row['audio'] ?? row['ruta_audio']);

    return {
      'id': id,
      'lesson_id': lessonId,
      'grammar_rule_id': grammarRuleId,
      'nahuatl_sentence': nahuatlSentence,
      'spanish_translation': spanishTranslation,
      'audio_path': audioPath,
    };
  }

  // ===========================================================================
  // UTILIDADES DE TIPADO SEGURO
  // ===========================================================================

  static int _parseInt(String? val, int fallback) {
    if (val == null) return fallback;
    final clean = val.trim();
    return int.tryParse(clean) ?? fallback;
  }

  static int? _parseNullableInt(String? val) {
    if (val == null) return null;
    final clean = val.trim();
    if (clean.isEmpty || clean.toLowerCase() == 'null') return null;
    return int.tryParse(clean);
  }

  static bool _parseBool(String? val, {bool fallback = false}) {
    if (val == null) return fallback;
    final clean = val.trim().toLowerCase();
    if (clean == 'true' || clean == '1' || clean == 'si' || clean == 'sí' || clean == 'yes') {
      return true;
    }
    if (clean == 'false' || clean == '0' || clean == 'no') {
      return false;
    }
    return fallback;
  }

  static String? _parseNullableString(String? val) {
    if (val == null) return null;
    final clean = val.trim();
    if (clean.isEmpty || clean.toLowerCase() == 'null') return null;
    return clean;
  }
}
