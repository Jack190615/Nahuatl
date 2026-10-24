import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../../../core/config/env_config.dart';
import 'app_database.dart';

/// Servicio encargado de la población inicial (Seeding) de la base de datos local.
/// Soporta tanto archivos JSON modulares por tabla en `assets/data/`:
/// - `assets/data/lessons.json`
/// - `assets/data/grammar_rules.json`
/// - `assets/data/dictionary.json`
/// - `assets/data/phrases.json`
/// como el archivo unificado `assets/data/initial_seed.json` configurado en `/.env`.
/// Ejecuta un Batch Insert atómico y transaccional únicamente en la primera instalación.
class DatabaseSeederService {
  static const String lessonsJsonPath = 'assets/data/lessons.json';
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

      final lessonsJson = payload['lessons'] ?? const [];
      final grammarRulesJson = payload['grammar_rules'] ?? const [];
      final dictionaryJson = payload['dictionary'] ?? const [];
      final phrasesJson = payload['phrases'] ?? const [];

      // 3. Mapear JSON a Companions de Drift
      final lessonCompanions = lessonsJson.map((item) {
        final map = item as Map<String, dynamic>;
        return LessonsCompanion.insert(
          id: map['id'] != null ? Value(map['id'] as int) : const Value.absent(),
          title: map['title'] as String,
          orderIndex: map['order_index'] as int,
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
          lessonId: map['lesson_id'] as int,
          grammarRuleId: Value(map['grammar_rule_id'] as int?),
          nahuatlSentence: map['nahuatl_sentence'] as String,
          spanishTranslation: map['spanish_translation'] as String,
          audioPath: Value(map['audio_path'] as String?),
        );
      }).toList();

      // 4. Ejecutar Batch Insert dentro de la transacción activa
      // Nota: El trigger `dictionary_ai` indexará automáticamente cada entrada en `dictionary_fts`.
      await _db.batch((batch) {
        batch.insertAll(
          _db.lessons,
          lessonCompanions,
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
    });
  }

  /// Intenta cargar primero los archivos JSON individuales por tabla en `assets/data/`;
  /// si no están presentes, recurre al archivo unificado `assets/data/initial_seed.json`.
  Future<Map<String, List<dynamic>>> _loadSeedPayloads() async {
    try {
      final lessonsRaw = await _assetBundle.loadString(lessonsJsonPath);
      final grammarRaw = await _assetBundle.loadString(grammarRulesJsonPath);
      final dictionaryRaw = await _assetBundle.loadString(dictionaryJsonPath);
      final phrasesRaw = await _assetBundle.loadString(phrasesJsonPath);

      return {
        'lessons': json.decode(lessonsRaw) as List<dynamic>,
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
        'grammar_rules':
            (decoded['grammar_rules'] as List<dynamic>?) ?? const [],
        'dictionary': (decoded['dictionary'] as List<dynamic>?) ?? const [],
        'phrases': (decoded['phrases'] as List<dynamic>?) ?? const [],
      };
    }
  }
}
