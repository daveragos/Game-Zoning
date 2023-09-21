import 'package:flutter_riverpod/flutter_riverpod.dart';

final positionProvider = StateNotifierProvider<Postioner, int>((ref) {
  return Postioner(1);
});

class Postioner extends StateNotifier<int> {
  Postioner(super.state);

  void setPosition(int value) {
    state = value;
  }
}

final toggleProvider = StateNotifierProvider((ref) => ToggleNotifier());

class ToggleNotifier extends StateNotifier<String> {
  ToggleNotifier() : super('owner');

  void setToggler(String value) {
    state = value;
    print(value);
  }
}
