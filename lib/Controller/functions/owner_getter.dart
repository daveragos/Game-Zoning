import 'package:flutter_riverpod/flutter_riverpod.dart';

final ownerProvider = StateNotifierProvider<OwnerNotifier, String>((ref) {
  return OwnerNotifier();
});

class OwnerNotifier extends StateNotifier<String> {
  OwnerNotifier() : super('');

  void setName(String name) {
    state = name;
  }
}
