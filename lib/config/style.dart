import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomColors {
  static const primary = Color.fromARGB(255, 187, 125, 125);
  static const offwhite = Color.fromARGB(255, 243, 243, 243);
  static const error = Color.fromARGB(255, 165, 18, 18);
  static const accent = Color.fromARGB(255, 28, 196, 126);
  static const grey = Color.fromARGB(255, 139, 139, 139);
  static const primaryGradient = LinearGradient(
      //stops: [0, 2],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [CustomColors.primary, Colors.transparent]);
}

final font = GoogleFonts.montserrat();
final fontTile = font.copyWith(
    fontWeight: FontWeight.bold, fontSize: 30, color: CustomColors.primary);
final fontName = font.copyWith(
    color: const Color.fromARGB(255, 187, 187, 187),
    fontSize: 20,
    fontWeight: FontWeight.w400);
final fontDescription =
    font.copyWith(fontSize: 16, fontWeight: FontWeight.w500);
