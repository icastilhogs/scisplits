import 'package:flutter/material.dart';
import 'package:scisplits/config/style.dart';

class MuscleStats extends StatelessWidget {
  const MuscleStats(
      {Key? key,
      required this.name,
      required this.seconds,
      required this.progress})
      : super(key: key);
  final String name;
  final int seconds;
  final double progress;

  Widget _buildProgress(double maxWidth) {
    return Row(
      children: [
        Stack(children: <Widget>[
          Container(
              //width: maxWidth,
              height: 5,
              color: HSLColor.fromColor(CustomColors.offwhite)
                  .withLightness(.5)
                  .toColor()),
          Container(
              width: maxWidth * progress,
              height: 5,
              color: CustomColors.accent),
        ]),
        Text('${progress * 100}%'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return ListTile(
      title: Text(name),
      subtitle: _buildProgress(maxWidth),
    );
  }
}
