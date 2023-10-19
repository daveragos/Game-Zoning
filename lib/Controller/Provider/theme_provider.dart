import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedThemeNotifier extends StateNotifier<bool> {
  SelectedThemeNotifier() : super(true);

  void setDate(bool theme) {
    state = theme;
  }

  void resetDate() {
    state = true;
  }
}

final selectedThemeProvider =
    StateNotifierProvider<SelectedThemeNotifier, bool>(
        (ref) => SelectedThemeNotifier());
