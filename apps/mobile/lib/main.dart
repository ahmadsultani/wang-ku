import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/register/signin_screen.dart';
import 'package:mobile/screens/register/signup_first_screen.dart';
import 'package:mobile/screens/register/signup_second_screen.dart';
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
        } else if (settings.name == '/signin') {
          return RouteAnimations.slide(settings, const SigninScreen());
        } else if (settings.name == '/signup-second') {
          final argument = settings.arguments as Map<String, dynamic>;
          return RouteAnimations.slide(
              settings,
              SignupSecondScreen(
                name: argument['name'] as String,
                email: argument['email'] as String,
                password: argument['password'] as String,
              ));
        } else {
          // return RouteAnimations.slide(settings, const SplashScreen());
        }
        return RouteAnimations.slide(settings, const SplashScreen());
      },
    ),
  );
}
