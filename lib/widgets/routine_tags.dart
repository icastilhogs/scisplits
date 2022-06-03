import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scisplits/config/style.dart';

class RoutineTags extends StatelessWidget {
  const RoutineTags(
      {Key? key,
      required this.icon,
      required this.text,
      this.color = CustomColors.primary})
      : super(key: key);

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
            color: color.withOpacity(.15),
            borderRadius: BorderRadius.circular(32.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            Text(
              text,
              style: font.copyWith(color: color),
            ),
          ],
        ));
  }
}
