import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final apiFavoritesProvider =
    StateNotifierProvider<ApiFavoritesNotifier, List<String>>(
      (ref) => ApiFavoritesNotifier(),
    );

class ApiFavoritesNotifier extends StateNotifier<List<String>> {
  ApiFavoritesNotifier() : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('api_favorites');
    print("Saved API Favorites => $data");
    if (data != null) {
      state = List<String>.from(jsonDecode(data));
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('api_favorites', jsonEncode(state));
  }

  Future<void> toggleFavorite(String email) async {
    if (state.contains(email)) {
      state = state.where((e) => e != email).toList();
    } else {
      state = [...state, email];
    }

    await saveFavorites();
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('api_favorites');

    state = [];
  }
}
