import 'package:flutter/material.dart';
import 'package:scisplits/data/models/global_timer.dart';

import 'action_bar.dart';
import 'timer_progress.dart';

class TimerViewer extends StatelessWidget {
  const TimerViewer({
    Key? key,
    required this.progress,
    required this.seconds,
    required this.status,
    required this.pause,
    //required this.cancel,
    required this.previous,
    required this.next,
    required this.restartExercise,
  }) : super(key: key);

  final double progress;
  final int seconds;
  final TimerStatus status;
  final VoidCallback pause;
  final VoidCallback restartExercise;
  final VoidCallback previous;
  final VoidCallback next;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TimerProgress(
          progress: progress,
          seconds: seconds,
        ),
        ActionBar(
          exerciseStatus: status,
          pauseExercise: pause,
          restartExercise: restartExercise,
          previousExercise: previous,
          skipExercise: next,
        ),
      ],
    );
  }
}
