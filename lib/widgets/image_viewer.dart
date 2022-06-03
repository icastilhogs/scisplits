import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({Key? key, required this.image, this.heightFactor = 1})
      : super(key: key);

  final String image;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Hero(
        tag: 'image',
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: Image.asset(
            key: ValueKey(image),
            'assets/img/$image',
            height: MediaQuery.of(context).size.height * heightFactor,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
