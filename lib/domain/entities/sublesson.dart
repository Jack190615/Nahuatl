/// Tipo o modalidad pedagógica del punto o sublección en el curso.
enum SublessonType {
  /// Contenido conceptual, fonética, ortografía o reglas morfosintácticas.
  theory,

  /// Vocabulario específico a memorizar (genera pares/matching y tarjetas de memoria).
  vocabulary,

  /// Ejercicios interactivos con oraciones completas (Word Bank, Text Input, traducción).
  phrases;

  static SublessonType fromString(String? raw) {
    if (raw == null) return SublessonType.theory;
    final lower = raw.trim().toLowerCase();
    if (lower == 'vocabulario' || lower == 'vocabulary' || lower == 'palabras') {
      return SublessonType.vocabulary;
    }
    if (lower == 'frases' || lower == 'oraciones' || lower == 'practica' || lower == 'phrases') {
      return SublessonType.phrases;
    }
    return SublessonType.theory;
  }

  String get asString {
    switch (this) {
      case SublessonType.theory:
        return 'teoria';
      case SublessonType.vocabulary:
        return 'vocabulario';
      case SublessonType.phrases:
        return 'frases';
    }
  }
}

/// Entidad de Dominio que representa un punto específico del libro
/// (ej. Punto 4, 5, 6, 7-9, 10, 11, 12).
class SublessonEntity {
  final int id;
  final int lessonId;
  final String pointNumber;
  final String title;
  final SublessonType type;
  final String? theoryContent;
  final int orderIndex;
  final bool isUnlocked;
  final bool isCompleted;

  const SublessonEntity({
    required this.id,
    required this.lessonId,
    required this.pointNumber,
    required this.title,
    required this.type,
    this.theoryContent,
    required this.orderIndex,
    required this.isUnlocked,
    this.isCompleted = false,
  });

  SublessonEntity copyWith({
    int? id,
    int? lessonId,
    String? pointNumber,
    String? title,
    SublessonType? type,
    String? theoryContent,
    int? orderIndex,
    bool? isUnlocked,
    bool? isCompleted,
  }) {
    return SublessonEntity(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      pointNumber: pointNumber ?? this.pointNumber,
      title: title ?? this.title,
      type: type ?? this.type,
      theoryContent: theoryContent ?? this.theoryContent,
      orderIndex: orderIndex ?? this.orderIndex,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
