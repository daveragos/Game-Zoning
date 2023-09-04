import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedTabProvider = StateNotifierProvider<SelectedTab, int>((ref) {
  return SelectedTab(0);
});

class SelectedTab extends StateNotifier<int> {
  SelectedTab(super.state);

  void setSelectedTab(int value) {
    state = value;
  }
}
