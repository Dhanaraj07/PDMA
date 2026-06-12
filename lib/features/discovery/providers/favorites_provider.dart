import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super([]) {
    loadFavorites();
  }

  final box = Hive.box('favorites');

  void loadFavorites() {
    state = List<String>.from(box.get('items', defaultValue: []));
  }

  void addFavorite(String email) {
    if (!state.contains(email)) {
      state = [...state, email];

      box.put('items', state);
    }
  }

  void removeFavorite(String email) {
    state = state.where((item) => item != email).toList();

    box.put('items', state);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<String>>(
      (ref) => FavoritesNotifier(),
    );
