import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.maxCount,
    required this.count,
    required this.progress,
  }) : super(key: key);

  final int maxCount;
  final int count;
  final double progress;
  final double height = 15;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final width = maxWidth * progress;

    return Stack(
      alignment: Alignment.bottomRight,
      children: _progress(width),
    );
  }

  List<Widget> _progress(double width) {
    //print('$maxCount and $count');
    final List<Widget> containers = [
      Container(
        height: height,
        //color: Colors.green,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.green,
              Colors.blue,
            ],
          ),
        ),
      ),
      AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        alignment: Alignment.topRight,
        width: width,
        height: height,
        color: const Color.fromARGB(255, 211, 211, 211),
      ),
    ];

    return containers;
  }
}
