import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class Counter extends StateNotifier<int> {
  Counter({required this.ref}) : super(0);

  final Ref ref;

  void increment() {
    state++;
    ref.read(imageProvider.notifier).updateImage();
  }

  void decrement() {
    state--;
    ref.read(imageProvider.notifier).updateImage();
  }

  void reset() {
    state = 0;
    ref.read(imageProvider.notifier).updateImage();
  }
}

class SectionsCounter extends StateNotifier<int> {
  SectionsCounter({required this.ref}) : super(0);

  final Ref ref;
}
