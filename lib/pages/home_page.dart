import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scisplits/config/style.dart';
import 'package:scisplits/data/models/muscle.dart';
import 'package:scisplits/widgets/blendmode.dart';
import 'package:scisplits/widgets/custom_card.dart';

import 'package:scisplits/widgets/custom_title.dart';
import 'package:scisplits/widgets/image_viewer.dart';
import 'package:scisplits/widgets/muscle_group.dart';
import 'package:scisplits/widgets/routine_card.dart';
import 'package:scisplits/widgets/scrollable_scaffold.dart';
import 'package:widget_mask/widget_mask.dart';

import '../data/providers.dart';
import '../widgets/main_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget title(String title, {bool main = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: main
            ? fontDescription.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )
            : fontDescription,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget number(String number, {double? size}) {
    return Text(
      number,
      textAlign: TextAlign.center,
      style: font.copyWith(
        fontSize: size ?? 30,
        fontWeight: FontWeight.bold,
        color: CustomColors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider);
    final timerController = ref.read(timerProvider.notifier);
    final routineController = ref.read(routineProvider);
    final image = ref.watch(imageProvider);

    return ScrollableScaffold(
      title: 'Hello, stretcher',
      floatingActionButton: MainTextButton(
        color: CustomColors.primary,
        onPressed: () {
          routineController.startRoutine(context);
          Navigator.pushNamed(context, '/player');
        },
        text: 'Start now 🤩',
        opaque: true,
      ),
      sidePadding: 8,
      bottomPadding: 120,
      expandedHeightFactor: .1,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bars)),
      ],
      body: [
        MuscleGroupImage(muscle: MuscleGroup.adductors),
        MuscleGroupImage(muscle: MuscleGroup.flexors),
        MuscleGroupImage(muscle: MuscleGroup.quadriceps),
        const CustomTitle('This week'),
        StaggeredGrid.count(
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          crossAxisCount: 12,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 6,
              mainAxisCellCount: 8,
              child: CustomCard(
                  child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  title('💪🏻 Muscles'),
                  number('23', size: 60),
                  title('muscle groups stretched', main: false),
                ],
              )),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 6,
              mainAxisCellCount: 4,
              child: CustomCard(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [title('📅 Days'), number('6')],
              )),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 6,
              mainAxisCellCount: 4,
              child: CustomCard(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title('⏱️ Total time'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [number('26'), title('hours', main: false)],
                  )
                ],
              )),
            )
          ],
        ),
        /* SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          child: Row(
            children: [
              Card(
                  color: CustomColors.primary,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  elevation: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: CustomColors.primary,
                      child: Text('blue'),
                    ),
                    Container(
                        color: CustomColors.primary,
                        child: Text('Thank u next')),
                  ],
                ),
              ),
            ],
          ),
        ), */
        /* SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 200,
                child: MuscleStats(
                  name: 'Right hamstring',
                  seconds: 180,
                  progress: .33,
                ),
              ),
            ],
          ),
        ), */
        const SizedBox(height: 18),
        const CustomTitle('Current routine'),
        RoutineCard(
            routineId: routineController.id,
            routineName: routineController.name,
            routineDuration: routineController.duration,
            image: image)
      ],
    );
  }
}
