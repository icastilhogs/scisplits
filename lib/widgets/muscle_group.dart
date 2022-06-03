import 'package:flutter/material.dart';
import 'package:scisplits/config/style.dart';
import 'package:scisplits/data/models/muscle.dart';
import 'package:scisplits/widgets/blendmode.dart';
import 'package:scisplits/widgets/custom_card.dart';
import 'package:scisplits/widgets/custom_title.dart';

class MuscleGroupImage extends StatelessWidget {
  const MuscleGroupImage({Key? key, required this.muscle}) : super(key: key);

  final MuscleGroup muscle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitle(muscle.groupName),
        CustomCard(
          child: SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/img/muscles/muscle_groups_grey.jpg',
                  fit: BoxFit.cover,
                ),
                BlendMask(
                  opacity: 1,
                  blendMode: BlendMode.color,
                  child: Image.asset(
                      'assets/img/muscles/${muscle.groupName}.jpg',
                      fit: BoxFit.cover,
                      color: CustomColors.primary,
                      colorBlendMode: BlendMode.screen),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
