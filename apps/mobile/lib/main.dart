import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/register/signup_first_screen_.dart';
import 'package:mobile/screens/splash_screens.dart';
import 'package:mobile/utils/route_animations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      onGenerateRoute: (settings) {
        if (settings.name == '/signup-first') {
          return RouteAnimations.slide(settings, const SignupFirstScreen());
        } else {
          // return RouteAnimations.slide(settings, const SplashScreen());
        }
        return RouteAnimations.slide(settings, const SplashScreen());
      },
    ),
  );
}
