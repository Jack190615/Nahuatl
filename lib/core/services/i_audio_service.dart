/// Principio de Inversión de Dependencias (DIP - SOLID):
/// Contrato abstracto para la reproducción de archivos de audio en `assets/audio/`.
abstract interface class IAudioService {
  /// Reproduce un archivo de audio desde los assets si [assetAudioPath] es válido.
  Future<void> playAsset(String? assetAudioPath);

  /// Detiene cualquier reproducción en curso.
  Future<void> stop();

  /// Evalúa defensivamente si la ruta de audio es reproducible.
  bool canPlay(String? assetAudioPath);
}
