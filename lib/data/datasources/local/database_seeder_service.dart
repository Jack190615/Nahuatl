import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../../../core/config/env_config.dart';
import 'app_database.dart';

/// Servicio encargado de la población inicial (Seeding) de la base de datos local.
/// Soporta tanto archivos JSON modulares por tabla en `assets/data/`:
/// - `assets/data/lessons.json`
/// - `assets/data/sublessons.json`
/// - `assets/data/grammar_rules.json`
/// - `assets/data/dictionary.json`
/// - `assets/data/phrases.json`
/// como el archivo unificado `assets/data/initial_seed.json` configurado en `/.env`.
/// Ejecuta un Batch Insert atómico y transaccional únicamente en la primera instalación
/// o bajo demanda mediante [forceReseed].
class DatabaseSeederService {
  static const String lessonsJsonPath = 'assets/data/lessons.json';
  static const String sublessonsJsonPath = 'assets/data/sublessons.json';
  static const String grammarRulesJsonPath = 'assets/data/grammar_rules.json';
  static const String dictionaryJsonPath = 'assets/data/dictionary.json';
  static const String phrasesJsonPath = 'assets/data/phrases.json';

  final AppDatabase _db;
  final AssetBundle _assetBundle;

  DatabaseSeederService({
    required AppDatabase db,
    AssetBundle? assetBundle,
  })  : _db = db,
        _assetBundle = assetBundle ?? rootBundle;

  /// Verifica si la base de datos ya fue poblada; si está vacía, ejecuta la carga inicial
  /// dentro de una transacción ACID utilizando `batch.insertAll`.
  ///
  /// Retorna `true` si se ejecutó el seeding por primera vez, o `false` si ya existían datos.
  Future<bool> seedIfNeeded() async {
    return _db.transaction(() async {
      // 1. Verificar si ya existen registros en la tabla `lessons`
      final countExpression = _db.lessons.id.count();
      final query = _db.selectOnly(_db.lessons)..addColumns([countExpression]);
      final currentCount = await query
          .map((row) => row.read(countExpression) ?? 0)
          .getSingle();

      if (currentCount > 0) {
        return false; // La base de datos ya fue inicializada previamente
      }

      // 2. Cargar los payloads JSON desde `assets/data/`
      final payload = await _loadSeedPayloads();
      return _insertPayload(payload);
    });
  }

  /// Limpia las tablas y vuelve a sembrar toda la base de datos desde los JSONs más recientes.
  /// Ideal para desarrollo cuando se actualizan los archivos CSV/JSON.
  Future<bool> forceReseed() async {
    return _db.transaction(() async {
      await _db.delete(_db.phrases).go();
      await _db.delete(_db.dictionary).go();
      await _db.delete(_db.grammarRules).go();
      await _db.delete(_db.sublessons).go();
      await _db.delete(_db.lessons).go();

      final payload = await _loadSeedPayloads();
      return _insertPayload(payload);
    });
  }

  Future<bool> _insertPayload(Map<String, List<dynamic>> payload) async {
    final lessonsJson = payload['lessons'] ?? const [];
    final sublessonsJson = payload['sublessons'] ?? const [];
    final grammarRulesJson = payload['grammar_rules'] ?? const [];
    final dictionaryJson = payload['dictionary'] ?? const [];
    final phrasesJson = payload['phrases'] ?? const [];

    // Mapear JSON a Companions de Drift
    final lessonCompanions = lessonsJson.map((item) {
      final map = item as Map<String, dynamic>;
      return LessonsCompanion.insert(
        id: map['id'] != null ? Value(map['id'] as int) : const Value.absent(),
        romanNumber: Value(map['roman_number'] as String?),
        title: map['title'] as String,
        description: Value(map['description'] as String?),
        orderIndex: map['order_index'] as int,
        isUnlocked: Value((map['is_unlocked'] as bool?) ?? false),
      );
    }).toList();

    final sublessonCompanions = sublessonsJson.map((item) {
      final map = item as Map<String, dynamic>;
      return SublessonsCompanion.insert(
        id: map['id'] != null ? Value(map['id'] as int) : const Value.absent(),
        lessonId: map['lesson_id'] as int,
        pointNumber: (map['point_number'] ?? map['numero_punto'] ?? '1').toString(),
        title: (map['title'] ?? map['titulo'] ?? '') as String,
        type: (map['type'] ?? map['tipo'] ?? 'teoria') as String,
        theoryContent: Value(map['theory_content'] as String?),
        orderIndex: (map['order_index'] as int?) ?? ((map['id'] as int?) ?? 1),
        isUnlocked: Value((map['is_unlocked'] as bool?) ?? false),
      );
    }).toList();

    final grammarCompanions = grammarRulesJson.map((item) {
      final map = item as Map<String, dynamic>;
      return GrammarRulesCompanion.insert(
        id: map['id'] != null ? Value(map['id'] as int) : const Value.absent(),
        lessonId: map['lesson_id'] as int,
        explanationText: map['explanation_text'] as String,
      );
    }).toList();

    final dictionaryCompanions = dictionaryJson.map((item) {
      final map = item as Map<String, dynamic>;
      return DictionaryCompanion.insert(
        id: map['id'] != null ? Value(map['id'] as int) : const Value.absent(),
        sublessonId: Value(map['sublesson_id'] as int?),
        nahuatlWord: map['nahuatl_word'] as String,
        spanishTranslation: map['spanish_translation'] as String,
        wordType: map['word_type'] as String,
        audioPath: Value(map['audio_path'] as String?),
      );
    }).toList();

    final phraseCompanions = phrasesJson.map((item) {
      final map = item as Map<String, dynamic>;
      return PhrasesCompanion.insert(
        id: map['id'] != null ? Value(map['id'] as int) : const Value.absent(),
        lessonId: Value(map['lesson_id'] as int?),
        sublessonId: Value(map['sublesson_id'] as int?),
        grammarRuleId: Value(map['grammar_rule_id'] as int?),
        nahuatlSentence: map['nahuatl_sentence'] as String,
        spanishTranslation: map['spanish_translation'] as String,
        audioPath: Value(map['audio_path'] as String?),
      );
    }).toList();

    // Ejecutar Batch Insert dentro de la transacción activa
    await _db.batch((batch) {
      batch.insertAll(
        _db.lessons,
        lessonCompanions,
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        _db.sublessons,
        sublessonCompanions,
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        _db.grammarRules,
        grammarCompanions,
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        _db.dictionary,
        dictionaryCompanions,
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        _db.phrases,
        phraseCompanions,
        mode: InsertMode.insertOrReplace,
      );
    });

    return true;
  }

  /// Intenta cargar primero los archivos JSON individuales por tabla en `assets/data/`;
  /// si no están presentes, recurre al archivo unificado `assets/data/initial_seed.json`.
  Future<Map<String, List<dynamic>>> _loadSeedPayloads() async {
    try {
      final lessonsRaw = await _assetBundle.loadString(lessonsJsonPath);
      final grammarRaw = await _assetBundle.loadString(grammarRulesJsonPath);
      final dictionaryRaw = await _assetBundle.loadString(dictionaryJsonPath);
      final phrasesRaw = await _assetBundle.loadString(phrasesJsonPath);

      List<dynamic> sublessonsList = const [];
      try {
        final sublessonsRaw = await _assetBundle.loadString(sublessonsJsonPath);
        sublessonsList = json.decode(sublessonsRaw) as List<dynamic>;
      } catch (_) {}

      return {
        'lessons': json.decode(lessonsRaw) as List<dynamic>,
        'sublessons': sublessonsList,
        'grammar_rules': json.decode(grammarRaw) as List<dynamic>,
        'dictionary': json.decode(dictionaryRaw) as List<dynamic>,
        'phrases': json.decode(phrasesRaw) as List<dynamic>,
      };
    } catch (_) {
      final unifiedJsonString =
          await _assetBundle.loadString(EnvConfig.seedJsonPath);
      final Map<String, dynamic> decoded =
          json.decode(unifiedJsonString) as Map<String, dynamic>;
      return {
        'lessons': (decoded['lessons'] as List<dynamic>?) ?? const [],
        'sublessons': (decoded['sublessons'] as List<dynamic>?) ?? const [],
        'grammar_rules':
            (decoded['grammar_rules'] as List<dynamic>?) ?? const [],
        'dictionary': (decoded['dictionary'] as List<dynamic>?) ?? const [],
        'phrases': (decoded['phrases'] as List<dynamic>?) ?? const [],
      };
    }
  }
}
