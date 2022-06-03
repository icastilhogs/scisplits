import 'dart:ui';

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.color = const Color.fromARGB(255, 85, 85, 85),
    this.opaque = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final bool opaque;

  Color get opaqueColor {
    return HSLColor.fromColor(color)
        .withLightness(.9)
        .toColor()
        .withOpacity(.8);
  }

  Color get highlightColor {
    return HSLColor.fromColor(color).withLightness(.9).toColor();
  }

  Color get splashColor {
    return HSLColor.fromColor(color)
        //.withLightness(1 - color.computeLuminance())
        //.withAlpha(.98)
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          //customBorder: const RoundedRectangleBorder(),
          radius: 15,
          borderRadius: BorderRadius.circular(24.0),
          splashColor: splashColor,
          hoverColor: highlightColor,
          highlightColor: highlightColor,
          onTap: onPressed,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                decoration: BoxDecoration(
                  color: opaque ? opaqueColor : color.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Icon(
                  icon,
                  size: 16.0,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
