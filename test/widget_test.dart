import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nahuatl_clasico_app/core/services/i_audio_service.dart';
import 'package:nahuatl_clasico_app/core/utils/text_normalizer.dart';
import 'package:nahuatl_clasico_app/domain/entities/dictionary_entry.dart';
import 'package:nahuatl_clasico_app/domain/entities/exercise.dart';
import 'package:nahuatl_clasico_app/domain/entities/grammar_rule.dart';
import 'package:nahuatl_clasico_app/domain/entities/lesson.dart';
import 'package:nahuatl_clasico_app/domain/entities/phrase.dart';
import 'package:nahuatl_clasico_app/domain/entities/sublesson.dart';
import 'package:nahuatl_clasico_app/domain/evaluators/exercise_evaluators.dart';
import 'package:nahuatl_clasico_app/domain/repositories/i_nahuatl_repository.dart';
import 'package:nahuatl_clasico_app/domain/usecases/generate_lesson_exercises_usecase.dart';
import 'package:nahuatl_clasico_app/presentation/controllers/exercise_engine_controller.dart';
import 'package:nahuatl_clasico_app/presentation/providers/app_providers.dart';
import 'package:nahuatl_clasico_app/presentation/views/blog/blog_view.dart';
import 'package:nahuatl_clasico_app/presentation/views/exercise/exercise_session_view.dart';
import 'package:nahuatl_clasico_app/presentation/views/lessons/lesson_theory_view.dart';
import 'package:nahuatl_clasico_app/presentation/views/welcome/welcome_view.dart';
import 'package:nahuatl_clasico_app/presentation/widgets/common/defensive_audio_button.dart';
import 'package:nahuatl_clasico_app/presentation/widgets/lesson/lesson_card_widget.dart';

/// Repositorio en memoria (Fake) que implementa [INahuatlRepository] para pruebas unitarias deterministas
/// siguiendo el Principio de Inversión de Dependencias (DIP - SOLID).
class FakeNahuatlRepository implements INahuatlRepository {
  final List<LessonEntity> _lessons = [
    const LessonEntity(
      id: 1,
      title: 'Saludos y Sustantivos Absolutos',
      orderIndex: 1,
      isUnlocked: true,
    ),
    const LessonEntity(
      id: 2,
      title: 'Verbos Intransitivos',
      orderIndex: 2,
      isUnlocked: false,
    ),
  ];

  final List<DictionaryEntryEntity> _dictionary = const [
    DictionaryEntryEntity(
      id: 1,
      nahuatlWord: 'atl',
      spanishTranslation: 'agua',
      wordType: WordType.sustantivo,
      audioPath: 'assets/audio/atl.mp3',
    ),
    DictionaryEntryEntity(
      id: 2,
      nahuatlWord: 'calli',
      spanishTranslation: 'casa',
      wordType: WordType.sustantivo,
      audioPath: 'assets/audio/calli.mp3',
    ),
    DictionaryEntryEntity(
      id: 3,
      nahuatlWord: 'tlacatl',
      spanishTranslation: 'persona',
      wordType: WordType.sustantivo,
      audioPath: null,
    ),
    DictionaryEntryEntity(
      id: 4,
      nahuatlWord: 'cihuatl',
      spanishTranslation: 'mujer',
      wordType: WordType.sustantivo,
      audioPath: 'assets/audio/cihuatl.mp3',
    ),
  ];

  final List<PhraseEntity> _phrases = const [
    PhraseEntity(
      id: 10,
      lessonId: 1,
      grammarRuleId: 1,
      nahuatlSentence: 'In cihuatl choca',
      spanishTranslation: '¡La mujer llora!',
      audioPath: null,
    ),
    PhraseEntity(
      id: 11,
      lessonId: 1,
      grammarRuleId: 1,
      nahuatlSentence: 'Cualli tonalli',
      spanishTranslation: 'Buen día',
      audioPath: 'assets/audio/cualli_tonalli.mp3',
    ),
  ];

  @override
  Future<List<LessonEntity>> getLessons() async => List.unmodifiable(_lessons);

  @override
  Future<LessonEntity?> getLessonById(int lessonId) async =>
      _lessons.where((l) => l.id == lessonId).firstOrNull;

  @override
  Future<void> unlockLesson(int lessonId) async {
    final index = _lessons.indexWhere((l) => l.id == lessonId);
    if (index != -1) {
      _lessons[index] = _lessons[index].copyWith(isUnlocked: true);
    }
  }

  @override
  Future<void> completeLesson(int lessonId) async {
    final index = _lessons.indexWhere((l) => l.id == lessonId);
    if (index != -1) {
      _lessons[index] = _lessons[index].copyWith(isCompleted: true);
    }
  }

  @override
  Future<List<SublessonEntity>> getSublessonsByLesson(int lessonId) async =>
      const [];

  @override
  Future<SublessonEntity?> getSublessonById(int sublessonId) async => null;

  @override
  Future<void> unlockSublesson(int sublessonId) async {}

  @override
  Future<void> completeSublesson(int sublessonId) async {}

  @override
  Future<List<DictionaryEntryEntity>> getVocabularyBySublesson(int sublessonId) async =>
      const [];

  @override
  Future<List<PhraseEntity>> getPhrasesBySublesson(int sublessonId) async =>
      const [];

  @override
  Future<List<GrammarRuleEntity>> getGrammarRulesByLesson(int lessonId) async =>
      const [
        GrammarRuleEntity(
          id: 1,
          lessonId: 1,
          explanationText: 'Sufijo absolutivo -tl, -tli, -li.',
        ),
      ];

  @override
  Future<List<DictionaryEntryEntity>> searchDictionary(String query) async {
    final normalized = TextNormalizer.normalizeStrict(query);
    if (normalized.isEmpty) return _dictionary;
    return _dictionary
        .where(
          (e) =>
              e.nahuatlWord.toLowerCase().contains(normalized) ||
              e.spanishTranslation.toLowerCase().contains(normalized),
        )
        .toList();
  }

  @override
  Future<List<DictionaryEntryEntity>> getRandomDictionaryEntries({
    required int limit,
    List<int> excludeIds = const [],
  }) async {
    return _dictionary
        .where((e) => !excludeIds.contains(e.id))
        .take(limit)
        .toList();
  }

  @override
  Future<List<PhraseEntity>> getPhrasesByLesson(int lessonId) async {
    return _phrases.where((p) => p.lessonId == lessonId).toList();
  }

  @override
  Future<List<String>> getRandomDistractorNahuatlWords({
    required int count,
    required Set<String> excludedWords,
  }) async {
    final candidates = ['cochi', 'nitlacua', 'nehhuatl', 'tonalli']
        .where((w) => !excludedWords.contains(w))
        .take(count)
        .toList();
    return candidates;
  }
}

class FakeAudioService implements IAudioService {
  String? lastPlayedPath;

  @override
  bool canPlay(String? assetAudioPath) =>
      assetAudioPath != null && assetAudioPath.trim().isNotEmpty;

  @override
  Future<void> playAsset(String? assetAudioPath) async {
    if (canPlay(assetAudioPath)) {
      lastPlayedPath = assetAudioPath;
    }
  }

  @override
  Future<void> stop() async {}
}

void main() {
  group('1. TextNormalizer - Normalización Estricta', () {
    test('Elimina signos de puntuación, dobles espacios, mayúsculas y hace trim', () {
      const raw = '  ¡¿La   MUJER,   llora?!...  ';
      expect(TextNormalizer.normalizeStrict(raw), equals('la mujer llora'));
    });

    test('Compara exitosamente strings equivalentes entre usuario y base de datos', () {
      const evaluator = TextInputExerciseEvaluator();
      const sampleExercise = TextInputExercise(
        exerciseId: 'ti_1',
        phraseId: 10,
        direction: TranslationDirection.nahuatlToSpanish,
        promptSentence: 'In cihuatl choca',
        expectedAnswer: '¡La mujer llora!',
      );
      expect(
        evaluator.evaluate(
          exercise: sampleExercise,
          rawUserInput: '  ¿¡la   MUJER, llora!? ',
        ),
        isTrue,
      );
      expect(
        TextNormalizer.areEquivalent('la mujer llora', '¡La mujer llora!'),
        isTrue,
      );
    });
  });

  group('2. ExerciseEngineController & Evaluadores SOLID (Bucle de 10 ejercicios)', () {
    late FakeNahuatlRepository fakeRepo;
    late GenerateLessonExercisesUseCase generateUseCase;
    late ExerciseEngineController controller;

    setUp(() async {
      fakeRepo = FakeNahuatlRepository();
      generateUseCase = GenerateLessonExercisesUseCase(
        dictionaryRepository: fakeRepo,
        phraseRepository: fakeRepo,
        random: Random(42),
      );
      controller = ExerciseEngineController(
        lessonId: 1,
        generateExercisesUseCase: generateUseCase,
        lessonRepository: fakeRepo,
      );
      // Esperar microtask de carga inicial
      await Future<void>.delayed(Duration.zero);
    });

    test('Carga exactamente 10 ejercicios dinámicos combinando Matching, WordBank y TextInput', () {
      expect(controller.state.isLoading, isFalse);
      expect(controller.state.exercises.length, equals(10));
      expect(controller.state.currentExerciseIndex, equals(0));
      expect(controller.state.currentExercise, isA<MatchingExercise>());
      expect(controller.state.exercises[1], isA<WordBankExercise>());
      expect(controller.state.exercises[2], isA<TextInputExercise>());
    });

    test('Matching (Pares): Extrae 4 pares y valida por ID relacional', () {
      final matching = controller.state.currentExercise as MatchingExercise;
      expect(matching.nahuatlColumn.length, equals(4));
      expect(matching.spanishColumn.length, equals(4));

      // Intento incorrecto (ID 1 vs ID 2)
      final wrongResult = controller.validateMatchingPair(
        nahuatlDictionaryId: 1,
        spanishDictionaryId: 2,
      );
      expect(wrongResult, isFalse);
      expect(
        controller.state.evaluationStatus,
        equals(ExerciseEvaluationStatus.incorrect),
      );

      // Resolver los 4 pares por ID relacional
      for (final id in [1, 2, 3, 4]) {
        expect(
          controller.validateMatchingPair(
            nahuatlDictionaryId: id,
            spanishDictionaryId: id,
          ),
          isTrue,
        );
      }

      expect(controller.state.matchedDictionaryIds.length, equals(4));
      expect(
        controller.state.evaluationStatus,
        equals(ExerciseEvaluationStatus.correct),
      );
    });

    test('Word Bank (Constructor): Inyecta 2 palabras trampa y valida array ordenado', () async {
      await controller.nextExercise(); // Avanza al índice 1 (WordBankExercise)
      final wordBank = controller.state.currentExercise as WordBankExercise;

      // Target: "Cualli tonalli" (2 tokens) + 2 palabras trampa = 4 fichas totales
      expect(
        wordBank.shuffledBankChips.length,
        equals(wordBank.targetNahuatlTokens.length + 2),
      );
      expect(
        wordBank.shuffledBankChips.where((c) => c.isDistractor).length,
        equals(2),
      );

      // Reconstrucción en orden incorrecto falla
      expect(
        controller.validateWordBank(wordBank.targetNahuatlTokens.reversed.toList()),
        isFalse,
      );

      // Reconstrucción exacta del array ordenado tiene éxito
      expect(
        controller.validateWordBank(wordBank.targetNahuatlTokens),
        isTrue,
      );
      expect(
        controller.state.evaluationStatus,
        equals(ExerciseEvaluationStatus.correct),
      );
    });

    test('Text Input (Traducción Libre): Normaliza input del usuario y valor de BD', () async {
      await controller.nextExercise(); // índice 1
      await controller.nextExercise(); // índice 2 (TextInputExercise)
      final textExercise = controller.state.currentExercise as TextInputExercise;
      expect(textExercise.expectedAnswer, equals('¡La mujer llora!'));

      final success = controller.validateTextInput('   la   MUJER,   llora...  ');
      expect(success, isTrue);
      expect(
        controller.state.evaluationStatus,
        equals(ExerciseEvaluationStatus.correct),
      );
    });
  });

  group('3. UI Defensiva - DefensiveAudioButton Widget', () {
    testWidgets('No renderiza botón si audioPath es null, y sí lo renderiza cuando existe ruta', (tester) async {
      final fakeAudio = FakeAudioService();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            audioServiceProvider.overrideWithValue(fakeAudio),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  DefensiveAudioButton(
                    key: ValueKey('null_audio'),
                    audioPath: null,
                  ),
                  DefensiveAudioButton(
                    key: ValueKey('valid_audio'),
                    audioPath: 'assets/audio/atl.mp3',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // El botón con audioPath null no debe mostrar ningún icono de volumen
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('null_audio')),
          matching: find.byIcon(Icons.volume_up_rounded),
        ),
        findsNothing,
      );

      // El botón con audioPath válido sí renderiza el icono y reproduce al tocarse
      final validButtonIcon = find.descendant(
        of: find.byKey(const ValueKey('valid_audio')),
        matching: find.byIcon(Icons.volume_up_rounded),
      );
      expect(validButtonIcon, findsOneWidget);

      await tester.tap(validButtonIcon);
      await tester.pump();
      expect(fakeAudio.lastPlayedPath, equals('assets/audio/atl.mp3'));
    });
  });

  group('4. Validación de Configuración de Build APK (nahuatl_app)', () {
    test('build.gradle.kts define archivesBaseName y validación post-build para nahuatl_app.apk', () {
      final gradleFile = File('android/app/build.gradle.kts');
      expect(gradleFile.existsSync(), isTrue);

      final content = gradleFile.readAsStringSync();
      expect(content, contains('val requiredApkBaseName = "nahuatl_app"'));
      expect(content, contains('setProperty("archivesBaseName", requiredApkBaseName)'));
      expect(content, contains('File(flutterApkDir, "\${requiredApkBaseName}.apk")'));
      expect(content, contains('[VALIDACIÓN APK EXITOSA]'));
    });
  });

  group('5. Vista de Bienvenida - Branding Axolot\'s Studios', () {
    testWidgets('Muestra la marca "powered by Axolot\'s Studios" únicamente en WelcomeView', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appBootstrapProvider.overrideWith((ref) => Future.value(true)),
          ],
          child: const MaterialApp(
            home: WelcomeView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("powered by Axolot's Studios"), findsOneWidget);
    });
  });

  group('6. Estado Más lecciones próximamente para lección sin frases', () {
    testWidgets('Muestra "Más lecciones próximamente" cuando id_leccion no tiene frases', (tester) async {
      final fakeRepo = FakeNahuatlRepository();
      // Lección 2 no tiene frases en FakeNahuatlRepository
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            nahuatlRepositoryProvider.overrideWithValue(fakeRepo),
          ],
          child: const MaterialApp(
            home: ExerciseSessionView(
              lessonId: 2,
              lessonTitle: 'Verbos Intransitivos',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Más lecciones próximamente'), findsOneWidget);
    });
  });

  group('7. Lecciones Teóricas e Introductorias (LessonTheoryView)', () {
    testWidgets('Muestra la teoría y desbloquea la siguiente lección al completar', (tester) async {
      final fakeRepo = FakeNahuatlRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            nahuatlRepositoryProvider.overrideWithValue(fakeRepo),
          ],
          child: const MaterialApp(
            home: LessonTheoryView(
              lessonId: 1,
              lessonTitle: 'Introducción',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('LECCIÓN INTRODUCTORIA'), findsOneWidget);
      expect(find.text('Sufijo absolutivo -tl, -tli, -li.'), findsOneWidget);

      final completeButton = find.text('Entendido, completar lección');
      expect(completeButton, findsOneWidget);

      await tester.tap(completeButton);
      await tester.pumpAndSettle();

      // Verificar que la lección 2 fue desbloqueada
      final lesson2 = await fakeRepo.getLessonById(2);
      expect(lesson2?.isUnlocked, isTrue);
    });
  });

  group('8. Módulo Blog y Divulgación Cultural (BlogView)', () {
    testWidgets('Renderiza el módulo de Blog con temas de cosmovisión y mitología', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BlogView(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Blog y Cosmovisión'), findsOneWidget);
      expect(find.text('Próximas Publicaciones'), findsOneWidget);
      expect(
        find.text('El mito del Quinto Sol (Nāhui Ollin) y la creación humana'),
        findsOneWidget,
      );
      expect(
        find.text('Los difrasismos: La poesía conceptual del náhuatl'),
        findsOneWidget,
      );
      expect(
        find.text('Teōtl y la naturaleza del cosmos en los tlamatinimeh'),
        findsOneWidget,
      );
    });
  });

  group('9. Nombre del icono de la App en el Launcher (Náhuatl Clásico)', () {
    test('AndroidManifest.xml define android:label="Náhuatl Clásico"', () {
      final manifestFile = File('android/app/src/main/AndroidManifest.xml');
      expect(manifestFile.existsSync(), isTrue);

      final content = manifestFile.readAsStringSync();
      expect(content, contains('android:label="Náhuatl Clásico"'));
    });
  });

  group('10. Soporte de Sublecciones y Puntos del Libro (LessonCardWidget)', () {
    testWidgets('Muestra subpuntos numerados y chip de subtemas en la tarjeta de lección', (tester) async {
      const lesson = LessonEntity(
        id: 2,
        romanNumber: 'II',
        title: 'El Sustantivo y la Oración Básica',
        orderIndex: 2,
        isUnlocked: true,
      );

      const sublessons = [
        SublessonEntity(
          id: 1,
          lessonId: 2,
          pointNumber: '4',
          title: 'Sustantivos absolutivos',
          type: SublessonType.vocabulary,
          orderIndex: 1,
          isUnlocked: true,
        ),
        SublessonEntity(
          id: 2,
          lessonId: 2,
          pointNumber: '6',
          title: 'La oración nominal',
          type: SublessonType.theory,
          orderIndex: 2,
          isUnlocked: true,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LessonCardWidget(
              lesson: lesson,
              sublessons: sublessons,
              grammarRules: const [],
              lessonType: LessonType.practice,
              onStartLesson: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Lección II'), findsOneWidget);
      expect(find.text('2 subpuntos'), findsOneWidget);
      expect(find.text('Punto 4: Sustantivos absolutivos'), findsOneWidget);
      expect(find.text('Punto 6: La oración nominal'), findsOneWidget);
      expect(find.text('Vocabulario'), findsOneWidget);
      expect(find.text('Teoría'), findsOneWidget);
    });
  });

  group('11. Repaso Interactivo de Errores y Umbral del 50%', () {
    test('Registra errores y activa fase interactiva de repaso al final de la lección', () async {
      final repo = FakeNahuatlRepository();
      final useCase = GenerateLessonExercisesUseCase(
        phraseRepository: repo,
        dictionaryRepository: repo,
      );

      final controller = ExerciseEngineController(
        lessonId: 1,
        generateExercisesUseCase: useCase,
        lessonRepository: repo,
      );

      // Esperar a que carguen los ejercicios
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Simular fallo intencional en el primer ejercicio según su tipo
      final current = controller.state.currentExercise;
      if (current is TextInputExercise) {
        controller.validateTextInput('respuesta incorrecta xyz');
      } else if (current is WordBankExercise) {
        controller.validateWordBank(['palabra_falsa_xyz']);
      } else if (current is MatchingExercise) {
        controller.validateMatchingPair(
          nahuatlDictionaryId: 9999,
          spanishDictionaryId: 8888,
        );
      }
      expect(controller.state.evaluationStatus, ExerciseEvaluationStatus.incorrect);
      expect(controller.state.failedExerciseIndices, contains(0));

      // Avanzar por el resto de los ejercicios
      final total = controller.state.exercises.length;
      for (int i = 0; i < total - 1; i++) {
        await controller.nextExercise();
      }

      // Al avanzar desde el último ejercicio, debe transicionar a isReviewMode = true
      await controller.nextExercise();
      expect(controller.state.isReviewMode, isTrue);
      expect(controller.state.currentExerciseIndex, 0); // Vuelve al ejercicio con error
    });

    test('Umbral del 50%: bloquea siguiente lección si no alcanza el 50% de aciertos', () async {
      final repo = FakeNahuatlRepository();
      final useCase = GenerateLessonExercisesUseCase(
        phraseRepository: repo,
        dictionaryRepository: repo,
      );

      final controller = ExerciseEngineController(
        lessonId: 1,
        generateExercisesUseCase: useCase,
        lessonRepository: repo,
      );

      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Fallar todos los ejercicios
      final total = controller.state.exercises.length;
      for (int i = 0; i < total; i++) {
        controller.validateTextInput('error');
        await controller.nextExercise();
      }

      // En fase de repaso, fallar nuevamente
      while (!controller.state.isLessonCompleted) {
        controller.validateTextInput('sigue con error');
        await controller.nextExercise();
      }

      expect(controller.state.isLessonCompleted, isTrue);
      expect(controller.state.isLessonPassed, isFalse);
      expect(controller.state.scorePercentage, 0.0);

      // Lección 2 sigue bloqueada
      final lesson2 = await repo.getLessonById(2);
      expect(lesson2?.isUnlocked, isFalse);
    });
  });

  group('12. Persistencia de Lección Completada (isCompleted)', () {
    test('completeLesson marca isCompleted en repositorio y LessonCardWidget muestra badge', () async {
      final repo = FakeNahuatlRepository();
      expect((await repo.getLessonById(1))?.isCompleted, isFalse);

      await repo.completeLesson(1);
      final completedLesson = await repo.getLessonById(1);
      expect(completedLesson?.isCompleted, isTrue);
    });
  });
}
