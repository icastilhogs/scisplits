import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 2,
      //margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      child: child ?? Container(),
    );
  }
}
