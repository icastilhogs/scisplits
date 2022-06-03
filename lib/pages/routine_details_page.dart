import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scisplits/config/style.dart';

import 'package:scisplits/widgets/exercise_card.dart';
import 'package:scisplits/widgets/routine_tags.dart';
import 'package:scisplits/widgets/scrollable_scaffold.dart';
import 'package:scisplits/widgets/custom_title.dart';

import '../data/providers.dart';
import '../widgets/main_button.dart';

class RoutineDetailsPage extends ConsumerWidget {
  const RoutineDetailsPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider);
    final timerController = ref.read(timerProvider.notifier);
    final routineController = ref.read(routineProvider);
    final routine = ref.watch(routineProvider);
    final image = ref.watch(imageProvider);

    List<Widget> _buildList() {
      final list = <Widget>[
        //Text(routine.description),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitle('Exercises'),
              Row(
                children: [
                  RoutineTags(
                      icon: CupertinoIcons.bolt_fill,
                      text: '${routine.basicRoutine.length} exercises'),
                  RoutineTags(
                      icon: CupertinoIcons.timer_fill, text: routine.duration),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                child: Text(
                  routine.description,
                  style: fontDescription,
                ),
              ),
            ],
          ),
        )
      ];
      list.addAll(routine.basicRoutine.map((exercise) {
        return ExerciseCard(
          id: exercise.id,
          title: exercise.name,
          description: exercise.status,
          sets: exercise.totalSets,
          tagetMuscles: exercise.targetMuscles.keys.map((e) => e.name).toList(),
          hasSides: exercise.hasSides,
          duration: exercise.duration,
          image: ref.read(imageProvider.notifier).getImage(exercise.type),
        );
      }));
      return list;
    }

    return ScrollableScaffold(
      title: routine.name,
      backButton: CupertinoNavigationBarBackButton(
        color: Colors.white,
        onPressed: () => Navigator.pushNamed(context, '/'),
      ),
      background: 'splits01.jpg',
      floatingActionButton: MainTextButton(
        onPressed: () {
          routineController.startRoutine(context);
          Navigator.pushNamed(context, '/player');
        },
        text: 'Start now 🤩',
        color: CustomColors.primary,
        opaque: true,
      ),
      body: _buildList(),
      bottomPadding: 120,
    );
  }
}
