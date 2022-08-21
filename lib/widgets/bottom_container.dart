import 'dart:ui';

import 'package:flutter/material.dart';

import '../config/style.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    Key? key,
    this.children,
    this.opaque = false,
    this.alignment = Alignment.bottomCenter,
    this.height,
  }) : super(key: key);

  final List<Widget>? children;
  final Alignment alignment;
  final double? height;
  final bool opaque;

  List<Widget> _buildWidgets(BuildContext context) {
    final List<Widget> list = [
      const Spacer(
        flex: 1,
      )
    ];
    if (children != null) {
      list.addAll(children!);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40), bottom: Radius.zero),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            //duration: Duration(seconds: 10),
            alignment: alignment,
            constraints: BoxConstraints(
              maxHeight:
                  height ?? MediaQuery.of(context).size.height * 0.82 + 40,
            ),
            decoration: BoxDecoration(
              //backgroundBlendMode: BlendMode.dstOut,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(-4, -4), // Shadow position
                ),
              ],
              color: opaque
                  ? CustomColors.offwhite
                  : CustomColors.offwhite.withOpacity(.9),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40), bottom: Radius.zero),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildWidgets(context),
            ),
          ),
        ),
      ),
    );
  }
}
