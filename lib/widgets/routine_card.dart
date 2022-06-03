import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scisplits/config/style.dart';
import 'package:scisplits/widgets/custom_card.dart';
import 'package:scisplits/widgets/image_viewer.dart';

class RoutineCard extends StatelessWidget {
  const RoutineCard(
      {Key? key,
      required this.routineId,
      required this.image,
      required this.routineName,
      required this.routineDuration})
      : super(key: key);

  final String routineId;
  final String routineName;
  final String routineDuration;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ImageViewer(heightFactor: .2, image: image),
          Positioned.fill(
            child: Container(
              decoration:
                  const BoxDecoration(gradient: CustomColors.primaryGradient),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    routineName,
                    style: font.copyWith(color: Colors.white, fontSize: 18),
                  ),
                ),
                const Icon(
                  CupertinoIcons.timer,
                  color: Colors.white,
                  size: 16,
                ),
                Text(
                  routineDuration,
                  style: font.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              surfaceTintColor: CustomColors.primary,
              color: Colors.transparent,
              child: InkWell(
                splashColor: CustomColors.primary.withOpacity(.5),
                highlightColor: Colors.white24,
                onTap: () {
                  Navigator.pushNamed(context, '/routine',
                      arguments: routineId);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
