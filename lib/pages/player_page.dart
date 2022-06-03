import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scisplits/data/models/global_timer.dart';

import 'package:scisplits/widgets/bottom_container.dart';
import 'package:scisplits/widgets/custom_icon_button.dart';
import 'package:scisplits/widgets/image_viewer.dart';
import 'package:scisplits/widgets/timer_viewer.dart';

import '../config/style.dart';
import '../data/models/exercise.dart';
import '../data/providers.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/progress_bar.dart';

class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final timerController = ref.read(timerProvider.notifier);

    if (state == AppLifecycleState.resumed) {
      timerController.isActive = true;
    } else if (state != AppLifecycleState.resumed) {
      timerController.isActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(timerProvider);
    final timerController = ref.read(timerProvider.notifier);
    final routine = ref.watch(routineProvider);
    final routineController = ref.read(routineProvider);
    final counter = ref.watch(counterProvider);
    final image = ref.watch(imageProvider);

    Exercise currentExercise = routine.currentExercise;

    void cancelRoutine(BuildContext context) {
      if (timer.status == TimerStatus.running) {
        timerController.pauseTimer(timer.seconds, context);
      }
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AlertDialog(
                titlePadding: const EdgeInsets.all(34),
                actionsPadding: const EdgeInsets.all(18),
                //actionsAlignment: MainAxisAlignment.center,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36))),
                backgroundColor: Colors.white.withOpacity(.95),
                title: Text('Cancel routine?',
                    style: font.copyWith(color: CustomColors.primary)),
                content: Text(
                  'If you quit you\'ll lose all your current progress. Are you sure you want to quit?',
                  style: font,
                ),
                actions: [
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (timer.status != TimerStatus.running) {
                        timerController.pauseTimer(timer.seconds, context);
                      }
                    },
                    text: 'Resume',
                  ),
                  CustomTextButton(
                    onPressed: () {
                      routineController.cancelRoutine(context);
                    },
                    text: 'Cancel routine',
                    color: CustomColors.error,
                  ),
                ],
              ),
            );
          });
    }

    return CustomScaffold(
      actions: [
        CustomIconButton(
          opaque: true,
          onPressed: () {
            cancelRoutine(context);
          },
          icon: CupertinoIcons.xmark,
        ),
      ],
      body: Stack(
        children: [
          ImageViewer(
            image: image,
            heightFactor: 0.6,
          ),
          BottomContainer(
            opaque: true,
            height: MediaQuery.of(context).size.height * 0.4 + 40,
            children: [
              Column(
                children: [
                  Text(
                    currentExercise.name,
                    style: fontName,
                  ),
                  Text(
                    currentExercise.status,
                    style: fontDescription,
                  ),
                ],
              ),
              TimerViewer(
                progress: timer.progress,
                seconds: timer.seconds,
                status: timer.status,
                pause: () => timerController.pauseTimer(timer.seconds, context),
                previous: routineController.previousExercise,
                next: () => routineController.skipExercise(context),
                restartExercise: () => timerController.startTimer(
                    routine.currentExercise.duration, false, context),
              ),
              ProgressBar(
                maxCount: routine.maxIndex,
                count: counter,
                progress: timer.progress,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
