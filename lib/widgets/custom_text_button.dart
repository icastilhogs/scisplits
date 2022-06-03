import 'package:flutter/material.dart';
import 'package:scisplits/config/style.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key, required this.onPressed, required this.text, this.color})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16),
          //onSurface: Colors.transparent,
          backgroundColor: color ?? Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: font.copyWith(
            //backgroundColor: color ?? Colors.transparent,
            color:
                color != null ? Colors.white : Theme.of(context).primaryColor,
          ),
        ));
  }
}
