import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static Future<bool> get isLightTheme async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLightTheme')!;
  }

  static Future<void> setTheme(bool isLight) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLightTheme', isLight);
  }
}

final themePreferenceProvider =
    StateNotifierProvider<ThemePreferenceNotifier, bool>(
  (ref) => ThemePreferenceNotifier(),
);

class ThemePreferenceNotifier extends StateNotifier<bool> {
  ThemePreferenceNotifier() : super(true);

  void toggleTheme() {
    state = !state;
    // Update the theme preference when the user toggles it.
    ThemePreference.setTheme(state);
  }
}
