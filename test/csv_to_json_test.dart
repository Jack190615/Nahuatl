import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import '../scripts/csv_to_json.dart';

void main() {
  group('CsvToJsonConverter Tests', () {
    final converter = CsvToJsonConverter();

    test('Convierte CSV delimitado por comas con comillas y campos vacios', () {
      const csv = '''id,nahuatl_word,spanish_translation,word_type,audio_path
1,atl,"agua, elemento vital",sustantivo,assets/audio/atl.mp3
2,calli,"casa ""hogar""",sustantivo,
3,tlacatl,persona,sustantivo,null
''';

      final rows = converter.parseCsvString(csv);
      expect(rows.length, equals(4)); // Header + 3 rows
      expect(rows[1][2], equals('agua, elemento vital'));
      expect(rows[2][2], equals('casa "hogar"'));
    });

    test('Detecta automaticamente delimitador punto y coma (Excel regional)', () {
      const csv = '''id;title;order_index;is_unlocked
1;Saludos y Sustantivos;1;si
2;Verbos;2;no
''';

      final rows = converter.parseCsvString(csv);
      expect(rows.length, equals(3));
      expect(rows[1][1], equals('Saludos y Sustantivos'));
      expect(rows[2][3], equals('no'));
    });

    test('Convierte directorio de prueba a JSONs estructurados', () {
      final tempIn = Directory.systemTemp.createTempSync('csv_in_');
      final tempOut = Directory.systemTemp.createTempSync('json_out_');

      try {
        final sampleCsv = File('${tempIn.path}/lessons.csv');
        sampleCsv.writeAsStringSync('id,title,order_index,is_unlocked\n1,Intro,1,true\n');

        final results = converter.convertDirectory(inputDir: tempIn, outputDir: tempOut);
        expect(results['lessons'], equals(1));

        final jsonFile = File('${tempOut.path}/lessons.json');
        expect(jsonFile.existsSync(), isTrue);

        final jsonContent = jsonFile.readAsStringSync();
        expect(jsonContent, contains('"title": "Intro"'));
        expect(jsonContent, contains('"is_unlocked": true'));
      } finally {
        tempIn.deleteSync(recursive: true);
        tempOut.deleteSync(recursive: true);
      }
    });
  });
}
