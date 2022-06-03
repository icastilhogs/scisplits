import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scisplits/widgets/custom_icon_button.dart';

import '../config/style.dart';
import '../data/models/global_timer.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    Key? key,
    //required this.startRoutine,
    //required this.cancelRoutine,
    required this.exerciseStatus,
    required this.pauseExercise,
    required this.skipExercise,
    required this.restartExercise,
    required this.previousExercise,
  }) : super(key: key);

  //final VoidCallback startRoutine;
  //final VoidCallback cancelRoutine;
  final TimerStatus exerciseStatus;
  final VoidCallback pauseExercise;
  final VoidCallback skipExercise;
  final VoidCallback restartExercise;
  final VoidCallback previousExercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomIconButton(
              onPressed: previousExercise, icon: CupertinoIcons.back),
          if (exerciseStatus == TimerStatus.running)
            CustomIconButton(
              onPressed: pauseExercise,
              icon: CupertinoIcons.pause,
              color: CustomColors.error,
            ),
          if (exerciseStatus == TimerStatus.paused)
            CustomIconButton(
              onPressed: pauseExercise,
              icon: CupertinoIcons.play_arrow_solid,
              color: Colors.blue,
            ),
          CustomIconButton(
              onPressed: skipExercise, icon: CupertinoIcons.forward),
        ],
      ),
    );
  }
}
