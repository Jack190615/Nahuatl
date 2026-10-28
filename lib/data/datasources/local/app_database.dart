import 'package:drift/drift.dart';

import '../../../core/utils/text_normalizer.dart';
import 'connection/connection.dart' as impl;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Lessons,
    Sublessons,
    GrammarRules,
    Dictionary,
    Phrases,
    ReadingQuestions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? impl.openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _createDictionaryFtsIndex();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(sublessons);
            await m.addColumn(lessons, lessons.romanNumber);
            await m.addColumn(lessons, lessons.description);
            await m.addColumn(dictionary, dictionary.sublessonId);
            await m.addColumn(phrases, phrases.sublessonId);
          }
          if (from < 3) {
            await m.addColumn(lessons, lessons.isCompleted);
            await m.addColumn(sublessons, sublessons.isCompleted);
          }
          if (from < 4) {
            await m.createTable(readingQuestions);
          }
        },
        beforeOpen: (details) async {
          // Habilitar integridad referencial (Foreign Keys) en SQLite
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Crea la tabla virtual nativa FTS5 de SQLite (`dictionary_fts`) vinculada a `dictionary`
  /// y sus tres triggers de sincronización automática (`INSERT`, `DELETE`, `UPDATE`).
  Future<void> _createDictionaryFtsIndex() async {
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS dictionary_fts USING fts5(
        nahuatl_word,
        spanish_translation,
        word_type,
        content='dictionary',
        content_rowid='id',
        tokenize='unicode61 remove_diacritics 2'
      );
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS dictionary_ai AFTER INSERT ON dictionary BEGIN
        INSERT INTO dictionary_fts(rowid, nahuatl_word, spanish_translation, word_type)
        VALUES (new.id, new.nahuatl_word, new.spanish_translation, new.word_type);
      END;
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS dictionary_ad AFTER DELETE ON dictionary BEGIN
        INSERT INTO dictionary_fts(dictionary_fts, rowid, nahuatl_word, spanish_translation, word_type)
        VALUES ('delete', old.id, old.nahuatl_word, old.spanish_translation, old.word_type);
      END;
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS dictionary_au AFTER UPDATE ON dictionary BEGIN
        INSERT INTO dictionary_fts(dictionary_fts, rowid, nahuatl_word, spanish_translation, word_type)
        VALUES ('delete', old.id, old.nahuatl_word, old.spanish_translation, old.word_type);
        INSERT INTO dictionary_fts(rowid, nahuatl_word, spanish_translation, word_type)
        VALUES (new.id, new.nahuatl_word, new.spanish_translation, new.word_type);
      END;
    ''');
  }

  /// Ejecuta una búsqueda Full-Text Search (FTS5) sobre `dictionary_fts` con soporte de prefijos
  /// y ordenamiento alfabético garantizado (A-Z) insensible a diacríticos/acentos.
  Future<List<DictionaryRow>> searchDictionaryFts(String rawQuery) async {
    final sanitized = TextNormalizer.normalizeStrict(rawQuery);
    if (sanitized.isEmpty) {
      final rows = await (select(dictionary)
            ..orderBy([
              (t) => OrderingTerm(
                    expression: t.nahuatlWord.collate(Collate.noCase),
                    mode: OrderingMode.asc,
                  ),
            ]))
          .get();

      // Ordenamiento natural alfabético insensible a tildes (á -> a, é -> e, etc.)
      rows.sort((a, b) {
        final normA = TextNormalizer.normalizeStrict(a.nahuatlWord);
        final normB = TextNormalizer.normalizeStrict(b.nahuatlWord);
        final cmp = normA.compareTo(normB);
        return cmp != 0 ? cmp : a.nahuatlWord.compareTo(b.nahuatlWord);
      });
      return rows;
    }

    // Construye expresión de coincidencia por prefijos (ej. "tlac*" OR "call*")
    final ftsMatchQuery = sanitized
        .split(' ')
        .where((token) => token.isNotEmpty)
        .map((token) => '"$token"*')
        .join(' OR ');

    final rows = await customSelect(
      '''
      SELECT d.*
      FROM dictionary_fts fts
      INNER JOIN dictionary d ON d.id = fts.rowid
      WHERE dictionary_fts MATCH ?
      ORDER BY bm25(dictionary_fts) ASC, d.nahuatl_word COLLATE NOCASE ASC
      ''',
      variables: [Variable.withString(ftsMatchQuery)],
      readsFrom: {dictionary},
    ).get();

    final resultRows =
        rows.map((QueryRow row) => dictionary.map(row.data)).toList();
    resultRows.sort((a, b) {
      final normA = TextNormalizer.normalizeStrict(a.nahuatlWord);
      final normB = TextNormalizer.normalizeStrict(b.nahuatlWord);
      final cmp = normA.compareTo(normB);
      return cmp != 0 ? cmp : a.nahuatlWord.compareTo(b.nahuatlWord);
    });
    return resultRows;
  }
}
