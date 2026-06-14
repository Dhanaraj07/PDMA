import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<int>>(
  (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<List<int>> {
  FavoritesNotifier() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('favorites');

    if (data != null) {
      final List decoded = jsonDecode(data);

      state = decoded.cast<int>();
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('favorites', jsonEncode(state));
  }

  Future<void> toggleFavorite(int index) async {
    if (state.contains(index)) {
      state = state.where((e) => e != index).toList();
    } else {
      state = [...state, index];
    }

    await saveFavorites();
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('favorites');

    state = [];
  }
}
