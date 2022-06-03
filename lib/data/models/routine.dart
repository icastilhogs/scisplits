import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'exercise.dart';
import '../providers.dart';

class Routine {
  Routine({
    required this.name,
    required this.description,
    required this.ref,
    //required this.timer,
    //required this.counter,
  });

  static const uuid = Uuid();

  final Ref ref;
  final String name;
  final String description;
  final String id = uuid.v4();

  final stopwatch = Stopwatch();

  String get duration {
    int sum = 0;
    for (Exercise exercise in _routine) {
      sum += exercise.duration;
    }
    return printDuration(Duration(seconds: sum), abbreviated: true);
  }

  //final Counter counter;
  //final GlobalTimerNotifier timer;
  final List<Exercise> _basicRoutine = [
    Exercise(type: Exercises.standingHamstring),
    Exercise(type: Exercises.forwardLunge),
    Exercise(type: Exercises.frontSplits),
  ];

  int get basicRoutineLength => _basicRoutine.length;
  List<Exercise> get basicRoutine => _basicRoutine;

  List<Exercise> get _routine {
    final List<Exercise> modifiedList = [];
    for (Exercise e in _basicRoutine) {
      final List<Exercise> sides = [];
      if (e.hasSides) {
        final left = e.copyWith(id: uuid.v4(), newLeg: Side.left);
        sides.addAll([e.copyWith(id: uuid.v4()), left]);
      } else {
        sides.add(e.copyWith(id: uuid.v4()));
      }
      if (e.totalSets > 1) {
        for (int rep = 1; rep <= e.totalSets; rep++) {
          final newReps = sides
              .map((e) => e.copyWith(id: uuid.v4(), newCurrentRep: rep))
              .toList();
          modifiedList.addAll(newReps);
        }
      }
    }
    //print(modifiedList.map((e) => e.name));
    return modifiedList;
  }

  List<bool>? routineResume;

  void completeExercise(int index) {
    routineResume?[index] = true;
  }

  List<Exercise> get routine => _routine;

  int get currentIndex => ref.read(counterProvider);
  int get maxIndex => _routine.length - 1;
  Exercise get currentExercise =>
      currentIndex <= maxIndex ? _routine[currentIndex] : _routine[0];
  Exercise? get nextExercise =>
      currentIndex < maxIndex ? _routine[currentIndex + 1] : null;

  Future<void> startRoutine(BuildContext context) async {
    routineResume = _routine.map((e) => false).toList();
    //print(_routine.map((e) => e.id));
    stopwatch.start();
    final timer = ref.read(timerProvider.notifier);
    timer.startTimer(currentExercise.duration, false, context);
  }

  void completeRoutine(BuildContext context) {
    Navigator.pushNamed(context, '/complete');
  }

  //working
  void cancelRoutine(BuildContext context) {
    //final elapsedTime = stopwatch.elapsed;
    stopwatch.stop();
    ref.read(timerProvider.notifier).cancelTimer();
    ref.read(counterProvider.notifier).reset();
    Navigator.pushNamed(context, '/complete');
    //print('Routine canceled with $elapsedTime');
  }

  //working
  void skipExercise(BuildContext context) {
    if (currentIndex < maxIndex) {
      ref.read(counterProvider.notifier).increment();
    } else {
      ref.read(counterProvider.notifier).reset();
      cancelRoutine(context);
    }
    ref.read(timerProvider.notifier).seconds = currentExercise.duration;
    ref.read(timerProvider.notifier).progress = 1.0;
    //print('Skipped to ${currentExercise.name}');
  }

  // working
  void previousExercise() {
    if (currentIndex > 0) {
      ref.read(counterProvider.notifier).decrement();
    } else {
      ref.read(counterProvider.notifier).reset();
    }
    ref.read(timerProvider.notifier).seconds = currentExercise.duration;
    ref.read(timerProvider.notifier).progress = 1.0;
    //print('Skipped to ${currentExercise.name}');
  }
}
