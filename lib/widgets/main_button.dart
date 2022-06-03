import 'dart:ui';

import 'package:flutter/material.dart';

import '../config/style.dart';

class MainTextButton extends StatelessWidget {
  const MainTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = const Color.fromARGB(255, 77, 77, 77),
    this.opaque = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color color;
  final bool opaque;

  Color get opaqueColor {
    return HSLColor.fromColor(color)
        .withLightness(.72)
        .toColor()
        .withOpacity(.75);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(12),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(Radius.circular(36.0)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width, 72),
                shadowColor: opaque
                    ? const Color.fromARGB(34, 19, 19, 19)
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36)),
                //padding: const EdgeInsets.symmetric(vertical: 24),
                primary: opaque ? opaqueColor : color.withOpacity(.15),
                onPrimary: color,
                textStyle: font.copyWith(fontSize: 20),
              ),
              onPressed: onPressed,
              child: Text(text,
                  style: font.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white))),
        ),
      ),
    );
  }
}
