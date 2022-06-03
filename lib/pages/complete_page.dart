import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scisplits/widgets/scrollable_scaffold.dart';

import '../config/style.dart';
import '../data/providers.dart';
import '../widgets/main_button.dart';

class CompletePage extends ConsumerWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final timer = ref.watch(timerProvider);
    //final timerController = ref.read(timerProvider.notifier);
    final routineController = ref.read(routineProvider);
    final image = ref.watch(imageProvider);
    final elapsedTime = routineController.stopwatch.elapsed;
    final routineResume = routineController.routineResume;

    List<Widget> _buildExerciseList() {
      final routine = routineController.routine;
      final List<Widget> list = [];

      final numberOfGroups = routineController.basicRoutineLength;

      for (var i = 0; i < numberOfGroups; i++) {
        final basicExercise = routineController.basicRoutine[i];
        final group = routine
            .where((exercise) => exercise.name == basicExercise.name)
            .toList();

        list.add(
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              style: ListTileStyle.list,
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(basicExercise.name,
                    style: font.copyWith(
                        fontSize: 23, color: CustomColors.primary)),
              ),
              subtitle: Column(
                children: group.map((e) {
                  final index =
                      routine.indexWhere((exercise) => exercise.id == e.id);
                  final isCompleted =
                      routineResume == null ? false : routineResume[index];
                  return ListTile(
                    trailing: isCompleted
                        ? const Icon(CupertinoIcons.check_mark,
                            color: Colors.green)
                        : const Icon(CupertinoIcons.xmark,
                            color: CustomColors.error),
                    title: Text(
                      e.status,
                      style: fontDescription,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      }
      return list;
    }

    return ScrollableScaffold(
      title: 'Resume',
      background: image,
      backButton: CupertinoNavigationBarBackButton(
        color: Colors.white,
        onPressed: () => Navigator.pushNamed(context, '/'),
      ),
      floatingActionButton: MainTextButton(
        color: CustomColors.primary,
        onPressed: () {
          routineController.startRoutine(context);
          Navigator.pushNamed(context, '/player');
        },
        text: 'Restart',
        opaque: true,
      ),
      customHeader: Container(
        color: CustomColors.offwhite,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 36),
        child: Text(
          'Elapsed time: ${printDuration(elapsedTime)}',
          style: font.copyWith(fontSize: 18),
        ),
      ),
      body: _buildExerciseList(),
    );
  }
}
