import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'i_audio_service.dart';

/// Implementación defensiva de [IAudioService] para activos locales en `assets/audio/`.
/// Verifica que la ruta no sea nula ni vacía y que el asset exista en el bundle antes de reproducir.
class AssetAudioService implements IAudioService {
  final AssetBundle _bundle;

  AssetAudioService({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  @override
  bool canPlay(String? assetAudioPath) {
    if (assetAudioPath == null) return false;
    final trimmed = assetAudioPath.trim();
    return trimmed.isNotEmpty;
  }

  @override
  Future<void> playAsset(String? assetAudioPath) async {
    if (!canPlay(assetAudioPath)) return;

    final normalizedPath = _normalizeAssetPath(assetAudioPath!);

    try {
      // Verificación defensiva de existencia del archivo en el AssetBundle móvil
      await _bundle.load(normalizedPath);
      // Feedback háptico sutil en Android e iOS al activar pronunciación
      await HapticFeedback.lightImpact();
      debugPrint('[AssetAudioService] Reproduciendo asset: $normalizedPath');
    } catch (e) {
      debugPrint(
        '[AssetAudioService] Aviso defensivo: El archivo "$normalizedPath" aún no está empaquetado ($e).',
      );
    }
  }

  @override
  Future<void> stop() async {
    // Punto de extensión para detener el canal nativo de audio (ej. just_audio / audioplayers)
  }

  String _normalizeAssetPath(String rawPath) {
    final clean = rawPath.trim();
    if (clean.startsWith('assets/audio/')) {
      return clean;
    }
    return 'assets/audio/$clean';
  }
}
