import 'package:flutter/material.dart';

import '../config/style.dart';

class TimerProgress extends StatelessWidget {
  const TimerProgress({Key? key, required this.progress, required this.seconds})
      : super(key: key);

  final double progress;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    //final style = Theme.of(context).textTheme.headline1;
    return SizedBox.square(
      dimension: 120,
      child: Stack(
        //fit: StackFit.expand,
        children: [
          Center(
            child: Text(
              seconds.toString(),
              style: font.copyWith(fontSize: 85, fontWeight: FontWeight.w300),
            ),
          ),
          /* CircularProgressIndicator(
            strokeWidth: 8.0,
            value: progress,
            //backgroundColor: Colors.blue,
            color: Colors.red,
          ), */
        ],
      ),
    );
  }
}
