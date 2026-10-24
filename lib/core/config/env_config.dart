import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuración centralizada de variables de entorno.
/// Asume estrictamente que el archivo `.env` se ubica en la raíz del proyecto (`/.env`).
class EnvConfig {
  EnvConfig._();

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String get seedJsonPath =>
      dotenv.maybeGet('SEED_JSON_PATH') ?? 'assets/data/initial_seed.json';

  static String get audioAssetsPrefix =>
      dotenv.maybeGet('AUDIO_ASSETS_PREFIX') ?? 'assets/audio/';

  static String get apiBaseUrl =>
      dotenv.maybeGet('API_BASE_URL') ?? 'https://api.nahuatl-app.example.com/v1';
}
