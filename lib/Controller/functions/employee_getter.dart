import 'package:flutter_riverpod/flutter_riverpod.dart';

final employeeProvider = StateNotifierProvider<EmployeeNotifier, String>((ref) {
  return EmployeeNotifier();
});

class EmployeeNotifier extends StateNotifier<String> {
  EmployeeNotifier() : super('');

  void setName(String name) {
    state = name;
  }
}
