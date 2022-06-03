import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:scisplits/config/style.dart';
import 'package:scisplits/data/models/muscle.dart';
import 'package:scisplits/widgets/blendmode.dart';

class MuscleGroupImage2 extends StatefulWidget {
  const MuscleGroupImage2({Key? key, required this.muscle}) : super(key: key);

  final MuscleGroup muscle;

  @override
  State<MuscleGroupImage2> createState() => _MuscleGroupImageState();
}

class _MuscleGroupImageState extends State<MuscleGroupImage2> {
  List<int> trim = [];

  Future<List<int>> getImg(bool isMask) async {
    Future<ByteData> bytes;
    if (isMask) {
      bytes =
          rootBundle.load('assets/img/muscles/${widget.muscle.groupName}.jpg');
      return bytes.then((value) => value.buffer.asUint8List());
    } else {
      final future = Future.delayed(Duration(seconds: 2)).then((_) {
        bytes = rootBundle.load('assets/img/muscles/muscle_groups_grey.jpg');
        return bytes.then((value) => value.buffer.asUint8List());
      });
      return future;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundBytes = getImg(false);
    final maskBytes = getImg(true);

    return Stack(
      alignment: Alignment.center,
      children: [
        /* Image.asset(
          'assets/img/muscles/muscle_groups_grey.jpg',
          fit: BoxFit.cover,
        ), */
/*         FutureBuilder(
            future: backgroundBytes,
            builder: (context, AsyncSnapshot<List<int>> snapshot) {
              if (snapshot.hasData) {
                final background = img.decodeImage(snapshot.data!);
                final croppedBackground = img.copyCrop(
                    background!, trim[0], trim[1], trim[2], trim[3]);
                return Image.memory(croppedBackground.getBytes());
              } else {
                return CupertinoActivityIndicator();
              }
            }), */
        FutureBuilder(
            future: maskBytes,
            builder: (context, AsyncSnapshot<List<int>> snapshot) {
              if (snapshot.hasData) {
                final mask = img.decodeJpg(snapshot.data!);
                trim = img.findTrim(mask!);
                final croppedMask =
                    img.copyCrop(mask, trim[0], trim[1], trim[2], trim[3]);
                return BlendMask(
                  opacity: 1,
                  blendMode: BlendMode.color,
                  child: Image.memory(croppedMask.data.buffer.asUint8List(),
                      fit: BoxFit.cover,
                      color: CustomColors.primary,
                      colorBlendMode: BlendMode.screen),
                );
              } else {
                return CupertinoActivityIndicator();
              }
            }),
      ],
    );
  }
}
