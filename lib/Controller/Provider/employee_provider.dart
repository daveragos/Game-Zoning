import 'package:flutter_riverpod/flutter_riverpod.dart';

//notifier provider
final selectedEmployeeProvider =
    StateNotifierProvider<SelectedEmployeeNotifier, int>(
        (ref) => SelectedEmployeeNotifier());

class SelectedEmployeeNotifier extends StateNotifier<int> {
  SelectedEmployeeNotifier() : super(0);

  //state updating method
  void setSelectedEmployee(int value) {
    state = value;
  }

  //state reading method
  int getSelectedEmployee() {
    return state;
  }
}
