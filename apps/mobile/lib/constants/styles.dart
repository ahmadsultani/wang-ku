import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalTextStyle {
  static final TextStyle heading1 = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 44, height: 1.31);
  static final TextStyle heading2 = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 36, height: 1.27);
  static final TextStyle heading3 = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 28, height: 1.35);
  static final TextStyle heading4 = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 24, height: 1.33);
  static final TextStyle heading5 = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 20, height: 1.3);
  static final TextStyle paragraph18 = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 18, height: 1.5);
  static final TextStyle paragraph16 = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 16, height: 1.5);
  static final TextStyle paragraph14 = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 14, height: 1.5);
  static final TextStyle label18 = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 18, height: 1.25);
  static final TextStyle label16 = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 16, height: 1.25);
  static final TextStyle label12 = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 12, height: 1.16);
}

abstract final class GlobalColor {
  static const int _defaultGrey = 0xFF70747E;
  static const MaterialColor grey = MaterialColor(_defaultGrey, <int, Color>{
    50: Color(0xFFEDEEF0),
    100: Color(0xFFCFD1D4),
    200: Color(0xFFB7BABF),
    300: Color(0xFF9FA3A9),
    400: Color(0xFF888C94),
    500: Color(_defaultGrey),
    600: Color(0xFF585D69),
    700: Color(0xFF404653),
    800: Color(0xFF282F3E),
    900: Color(0xFF0B121F),
  });

  static const int _defaultNeutral = 0xFF8A8A8A;
  static const MaterialColor neutral =
      MaterialColor(_defaultNeutral, <int, Color>{
    50: Color(0xFFE8E8E8),
    100: Color(0xFFD0D0D0),
    200: Color(0xFFB9B9B9),
    300: Color(0xFFA1A1A1),
    400: Color(0xFF8A8A8A),
    500: Color(0xFF727272),
    600: Color(0xFF5B5B5B),
    700: Color(0xFF595959),
    800: Color(0xFF262626),
    900: Color(0xFF000000),
  });

  // primary
  static const int _defaultPrimary = 0xFF2ABE60;
  static MaterialColor primary =
      const MaterialColor(_defaultPrimary, <int, Color>{
    50: Color(0xFFCCEFD9),
    100: Color(0xFFAAE5BF),
    200: Color(0xFF80D89F),
    300: Color(0xFF55CB80),
    400: Color(0xFF2ABE60),
    500: Color(0xFF00B140),
    600: Color(0xFF00762B),
    700: Color(0xFF208746),
    800: Color(0xFF005820),
    900: Color(0xFF00230D),
  });

  // secondary
  static const int _defaultSecondary = 0xFF554700;
  static MaterialColor secondary =
      const MaterialColor(_defaultSecondary, <int, Color>{
    // 255 85 71
    50: Color(0xFF554700),
    100: Color(0xFF806A00),
    200: Color(0xFFAA8D00),
    300: Color(0xFFD4B100),
    400: Color(0xFFFFD400),
    500: Color(0xFFFFDB2A),
    600: Color(0xFFFFE255),
    700: Color(0xFFFFE980),
    800: Color(0xFFFFF1AA),
    900: Color(0xFFFFF6CC),
  });

  static const int _defaultError = 0xFFF04438;
  static const MaterialColor error = MaterialColor(_defaultError, <int, Color>{
    100: Color(0xFFFEE4E2),
    200: Color(0xFFFECDCA),
    300: Color(0xFFFDA29B),
    400: Color(0xFFF97066),
    500: Color(_defaultError),
    600: Color(0xFFD92D20),
    700: Color(0xFFB32318),
    800: Color(0xFF912018),
    900: Color(0xFF7A271A),
  });
}
