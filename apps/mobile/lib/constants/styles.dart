import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalTextStyle {
  static final TextStyle title1 =
      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 26);
  static final TextStyle title2 =
      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 22);
  static final TextStyle title3 = GoogleFonts.poppins(fontSize: 18);
  static final TextStyle title4 =
      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18);
  static final TextStyle ext1 = GoogleFonts.poppins(fontSize: 16);
  static final TextStyle ext2 =
      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16);
  static final TextStyle headline1 = GoogleFonts.poppins(fontSize: 15);
  static final TextStyle headline2 =
      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15);
  static final TextStyle subhead1 = GoogleFonts.poppins(fontSize: 14);
  static final TextStyle subhead2 =
      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14);
  static final TextStyle caption1 = GoogleFonts.poppins(fontSize: 13);
  static final TextStyle caption2 = GoogleFonts.poppins(fontSize: 12);
  static final TextStyle caption3 = GoogleFonts.poppins(fontSize: 11);
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

  // primary
  static const int _defaultPrimary = 0xFF00230D;
  static MaterialColor primary =
      const MaterialColor(_defaultPrimary, <int, Color>{
    // 255 0 5
    50: Color(0XFF00230D),
    100: Color(0XFF005820),
    200: Color(0XFF208746),
    300: Color(0XFF00762B),
    400: Color(0XFF00B140),
    500: Color(0XFF2ABE60),
    600: Color(0XFF55CB80),
    700: Color(0XFF80D89F),
    800: Color(0XFFAAE5BF),
    900: Color(0XFFCCEFD9),
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
