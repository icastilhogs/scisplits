import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

enum TimerStatus {
  none,
  running,
  paused,
  canceled,
  completed,
}

class GlobalTimerNotifier extends ChangeNotifier {
  GlobalTimerNotifier({
    required this.ref,
  });

  final Ref ref;

  int maxSeconds = 1;
  int seconds = 0;
  double progress = 1;
  TimerStatus status = TimerStatus.none;
  Timer? _timer;

  bool isActive = true;

  static AudioCache player = AudioCache();
  static const countdown = "audio/countdown.wav";

  Future<void> startTimer(
      int thisMaxSeconds, bool resume, BuildContext context) async {
    //final currentExercise = ref.read(routineProvider).currentExercise;
    if (resume == false) {
      ref.read(imageProvider.notifier).updateImage();
      //print(previous);
      maxSeconds = thisMaxSeconds;
    }
    status = TimerStatus.running;
    seconds = thisMaxSeconds;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      //print(timer.tick);
      _timer = timer;
      if (seconds > 0 && isActive) {
        if (timer.tick == thisMaxSeconds - 3) {
          player.play(countdown);
        }
        seconds--;
        progress = seconds / maxSeconds;
      } else if (!isActive) {
        timer.cancel();
        status = TimerStatus.paused;
      } else {
        timer.cancel();
        //print('Completed');
        status = TimerStatus.completed;
        final routine = ref.read(routineProvider);
        routine.completeExercise(ref.read(counterProvider));
        //print(routine.routineResume[ref.read(counterProvider)]);
        ref.read(counterProvider.notifier).increment();
        callNext(context);
      }
      notifyListeners();
    });
  }

  void callNext(BuildContext context) {
    final routine = ref.read(routineProvider);
    final index = ref.read(counterProvider);
    final maxIndex = routine.maxIndex;
    if (index <= maxIndex) {
      final exercise = routine.currentExercise;
      startTimer(exercise.duration, false, context);
    } else {
      // TODO navigate to complete page
      routine.completeRoutine(context);
    }
  }

  void pauseTimer(int seconds, BuildContext context) {
    if (_timer!.isActive) {
      //print('pausing');
      status = TimerStatus.paused;
      _timer!.cancel();
    } else {
      //print('resuming');
      status = TimerStatus.running;
      startTimer(seconds, true, context);
    }
    notifyListeners();
  }

  void cancelTimer() {
    _timer!.cancel();
    seconds = 0;
    progress = 1;
    status = TimerStatus.canceled;
    //ref.read(counterProvider.notifier).reset();
    notifyListeners();
  }
}
