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
