import 'package:flutter/material.dart';
import 'package:scisplits/config/style.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle(this.title, {Key? key}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
      child: Text(
        title,
        style: font.copyWith(
            //fontWeight: FontWeight.bold,
            fontSize: 30,
            color: CustomColors.primary),
      ),
    );
  }
}
