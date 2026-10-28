/// Entidad de Dominio que representa una pregunta de comprensión de lectura en náhuatl.
class ReadingQuestionEntity {
  final int id;
  final int sublessonId;
  final int? questionNumber;
  final String questionNahuatl;
  final String correctAnswer;
  final String? questionTranslationSpanish;
  final String? audioPath;

  const ReadingQuestionEntity({
    required this.id,
    required this.sublessonId,
    this.questionNumber,
    required this.questionNahuatl,
    required this.correctAnswer,
    this.questionTranslationSpanish,
    this.audioPath,
  });

  bool get hasAudio => audioPath != null && audioPath!.trim().isNotEmpty;
}
