/// Utilidad de normalización estricta para evaluación de ejercicios de texto libre
/// y sanitización de consultas FTS5.
class TextNormalizer {
  TextNormalizer._();

  /// Expresión regular que detecta signos de puntuación comunes en español y náhuatl
  /// (incluyendo apertura/cierre de interrogación y exclamación, comillas, guiones, etc.).
  static final RegExp _punctuationRegex = RegExp(
    r'''[¡!¿?.,;:"'«»“”‘’()\[\]{}\-—_\/\\|@#$%^&*+=~`<>]''',
  );

  /// Expresión regular para colapsar múltiples espacios o tabulaciones seguidas.
  static final RegExp _multipleSpacesRegex = RegExp(r'\s+');

  /// Normaliza estrictamente una cadena de texto:
  /// 1. Convierte a minúsculas (`toLowerCase()`).
  /// 2. Elimina todos los signos de puntuación.
  /// 3. Colapsa dobles o múltiples espacios a un único espacio simple (`' '`).
  /// 4. Elimina espacios iniciales y finales (`trim()`).
  static String normalizeStrict(String input) {
    return input
        .toLowerCase()
        .replaceAll(_punctuationRegex, '')
        .replaceAll(_multipleSpacesRegex, ' ')
        .trim();
  }

  /// Compara dos cadenas (ej. respuesta del usuario vs traducción en base de datos)
  /// aplicando normalización estricta a ambos lados.
  static bool areEquivalent(String userInput, String expectedDatabaseValue) {
    final normalizedUser = normalizeStrict(userInput);
    final normalizedExpected = normalizeStrict(expectedDatabaseValue);
    if (normalizedUser.isEmpty || normalizedExpected.isEmpty) {
      return false;
    }
    return normalizedUser == normalizedExpected;
  }
}
