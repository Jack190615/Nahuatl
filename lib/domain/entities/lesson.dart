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
  final String title;
  final int orderIndex;
  final bool isUnlocked;

  const LessonEntity({
    required this.id,
    required this.title,
    required this.orderIndex,
    required this.isUnlocked,
  });

  LessonEntity copyWith({
    int? id,
    String? title,
    int? orderIndex,
    bool? isUnlocked,
  }) {
    return LessonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
