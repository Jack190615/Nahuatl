class PhraseEntity {
  final int id;
  final int lessonId;
  final int? sublessonId;
  final int? grammarRuleId;
  final String nahuatlSentence;
  final String spanishTranslation;
  final String? audioPath;

  const PhraseEntity({
    required this.id,
    required this.lessonId,
    this.sublessonId,
    this.grammarRuleId,
    required this.nahuatlSentence,
    required this.spanishTranslation,
    this.audioPath,
  });

  /// UI Defensiva: Indica si la frase posee un recurso de audio reproducible.
  bool get hasAudio => audioPath != null && audioPath!.trim().isNotEmpty;

  /// Ruta garantizada en `assets/audio/` o `null` si no tiene audio disponible.
  String? get resolvedAssetAudioPath {
    if (!hasAudio) return null;
    final cleanPath = audioPath!.trim();
    if (cleanPath.startsWith('assets/audio/')) {
      return cleanPath;
    }
    return 'assets/audio/$cleanPath';
  }

  /// Divide la oración en náhuatl en tokens limpios usando `split(' ')`.
  List<String> get nahuatlTokens => nahuatlSentence
      .trim()
      .split(' ')
      .where((token) => token.trim().isNotEmpty)
      .toList(growable: false);
}
