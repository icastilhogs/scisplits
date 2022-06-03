import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scisplits/data/models/exercise.dart';
import 'package:scisplits/data/providers.dart';

class Images extends StateNotifier<String> {
  Images({required this.ref}) : super('splits01.jpg');

  final Ref ref;

  static const List<String> _images = [
    'hamstring01.jpeg',
    'hamstring02.jpg',
    'lunge01.jfif',
    'lunge02.jpg',
    'lunge03.jpeg',
    'lunge04.jpeg',
    'lunge05.webp',
    'lunge06.jpeg',
    'lunge07.jpeg',
    'lunge08.jpeg',
    'lunge09.jpeg',
    'msplits01.jpeg',
    'shamstring01.jpeg',
    'shamstring02.webp',
    'splits01.jpg',
    'splits02.jpeg',
    'splits03.jpeg',
    'splits04.jpeg',
    'splits05.jpg',
    'splits06.jpeg',
    'splits07.webp',
    'splits08.jpeg',
    'splits09.jpeg',
    'splits10.jpeg',
  ];

  final random = Random();

  String getImage(Exercises type) {
    switch (type) {
      case Exercises.forwardLunge:
        return lunge;
      case Exercises.standingHamstring:
        return standingHamstring;

      case Exercises.frontSplits:
        return splits;

      default:
        return splits;
    }
  }

  String get standingHamstring {
    final list = _images.where((img) => img.contains('shamstring')).toList();
    final index = random.nextInt(list.length);
    return list[index];
  }

  String get lunge {
    final list = _images.where((img) => img.contains('lunge')).toList();
    final index = random.nextInt(list.length);
    return list[index];
  }

  String get splits {
    final allplits = _images.where((img) => img.contains('splits')).toList();
    allplits.removeWhere((img) => img.contains('msplits'));
    int index;
    do {
      index = random.nextInt(allplits.length);
    } while (allplits[index] == 'splits01.jpg');
    return allplits[index];
  }

  void updateImage() {
    final type = ref.read(routineProvider).currentExercise.type;
    state = getImage(type);
    //return previousState;
  }
}
