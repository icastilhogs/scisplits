import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scisplits/config/style.dart';
import 'package:scisplits/widgets/custom_card.dart';
import 'package:scisplits/widgets/image_viewer.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.sets,
    required this.tagetMuscles,
    required this.hasSides,
    required this.duration,
    required this.image,
  }) : super(key: key);

  final String id;
  final String title;
  final String description;
  final String image;
  final int sets;
  final List<String> tagetMuscles;
  final bool hasSides;
  final int duration;

  int get legs => hasSides ? 2 : 1;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.all(0),
            clipBehavior: Clip.hardEdge,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(32.0)),
            child: SizedBox(
              height: 130,
              width: MediaQuery.of(context).size.width * .3,
              child: Image.asset(
                'assets/img/$image',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: font.copyWith(color: CustomColors.primary)),
                        Text('${duration.toString()}s per set', style: font),
                        Text('$sets sets${hasSides ? '/leg' : null}',
                            style: font),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        CupertinoIcons.info,
                        color: CustomColors.primary.withOpacity(.5),
                      ),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.timer,
                            color: CustomColors.grey,
                            size: 16, //CustomColors.accent,
                          ),
                          const SizedBox.square(dimension: 5.0),
                          Text(
                            printDuration(
                                Duration(seconds: duration * sets * legs),
                                abbreviated: true),
                            style: font.copyWith(color: CustomColors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
