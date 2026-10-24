import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/dictionary_entry.dart';
import '../../domain/repositories/i_nahuatl_repository.dart';

@immutable
class DictionarySearchState {
  final String query;
  final bool isLoading;
  final List<DictionaryEntryEntity> results;
  final String? errorMessage;

  const DictionarySearchState({
    this.query = '',
    this.isLoading = false,
    this.results = const [],
    this.errorMessage,
  });

  DictionarySearchState copyWith({
    String? query,
    bool? isLoading,
    List<DictionaryEntryEntity>? results,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DictionarySearchState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Controlador con Responsabilidad Única (SRP) e Interfaces Segregadas (ISP):
/// Depende únicamente de [IDictionaryRepository] para ejecutar consultas FTS5.
class DictionarySearchController extends StateNotifier<DictionarySearchState> {
  final IDictionaryRepository _dictionaryRepository;

  DictionarySearchController({
    required IDictionaryRepository dictionaryRepository,
  })  : _dictionaryRepository = dictionaryRepository,
        super(const DictionarySearchState()) {
    search('');
  }

  Future<void> search(String rawQuery) async {
    state = state.copyWith(query: rawQuery, isLoading: true, clearError: true);
    try {
      final entries = await _dictionaryRepository.searchDictionary(rawQuery);
      state = state.copyWith(isLoading: false, results: entries);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error en búsqueda FTS5: $e',
      );
    }
  }
}
