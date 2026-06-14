import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    state = prefs.getBool('dark_mode') ?? false;
  }

  Future<void> toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('dark_mode', value);

    state = value;
  }
}
