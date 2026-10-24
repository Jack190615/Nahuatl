/// Categorías gramaticales soportadas en el diccionario de Náhuatl Clásico.
enum WordType {
  sustantivo('sustantivo'),
  verbo('verbo'),
  particula('partícula'),
  adjetivo('adjetivo'),
  pronombre('pronombre'),
  adverbio('adverbio'),
  numeral('numeral'),
  conjuncion('conjunción'),
  posposicion('posposición'),
  locativo('locativo'),
  otro('otro');

  final String value;
  const WordType(this.value);

  static WordType fromString(String raw) {
    final normalized = raw
        .trim()
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u');

    return switch (normalized) {
      'sustantivo' => WordType.sustantivo,
      'verbo' => WordType.verbo,
      'particula' => WordType.particula,
      'adjetivo' => WordType.adjetivo,
      'pronombre' => WordType.pronombre,
      'adverbio' => WordType.adverbio,
      'numeral' => WordType.numeral,
      'conjuncion' => WordType.conjuncion,
      'posposicion' => WordType.posposicion,
      'locativo' => WordType.locativo,
      _ => WordType.values.firstWhere(
          (e) => e.value.toLowerCase() == raw.trim().toLowerCase(),
          orElse: () => WordType.otro,
        ),
    };
  }
}

class DictionaryEntryEntity {
  final int id;
  final int? sublessonId;
  final String nahuatlWord;
  final String spanishTranslation;
  final WordType wordType;
  final String? audioPath;

  const DictionaryEntryEntity({
    required this.id,
    this.sublessonId,
    required this.nahuatlWord,
    required this.spanishTranslation,
    required this.wordType,
    this.audioPath,
  });

  /// UI Defensiva: Determina si el registro cuenta con un archivo de audio válido.
  /// La UI debe usar esta bandera para renderizar condicionalmente el botón de reproducción.
  bool get hasAudio => audioPath != null && audioPath!.trim().isNotEmpty;

  /// Devuelve la ruta normalizada dentro de `assets/audio/` únicamente si [hasAudio] es `true`.
  String? get resolvedAssetAudioPath {
    if (!hasAudio) return null;
    final cleanPath = audioPath!.trim();
    if (cleanPath.startsWith('assets/audio/')) {
      return cleanPath;
    }
    return 'assets/audio/$cleanPath';
  }
}
