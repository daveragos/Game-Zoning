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
