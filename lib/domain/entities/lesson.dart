/// Modalidad de contenido de una lección en la ruta de aprendizaje.
enum LessonType {
  /// Lección interactiva con bucle de 10 ejercicios dinámicos (Pares, Constructor, Traducción).
  practice,

  /// Lección teórica / gramatical / introductoria (reglas fonéticas, ortografía, conceptos).
  theory,

  /// Lección en desarrollo sin contenido cargado todavía.
  comingSoon,
}

class LessonEntity {
  final int id;
  final String? romanNumber;
  final String title;
  final String? description;
  final int orderIndex;
  final bool isUnlocked;

  const LessonEntity({
    required this.id,
    this.romanNumber,
    required this.title,
    this.description,
    required this.orderIndex,
    required this.isUnlocked,
  });

  LessonEntity copyWith({
    int? id,
    String? romanNumber,
    String? title,
    String? description,
    int? orderIndex,
    bool? isUnlocked,
  }) {
    return LessonEntity(
      id: id ?? this.id,
      romanNumber: romanNumber ?? this.romanNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      orderIndex: orderIndex ?? this.orderIndex,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
