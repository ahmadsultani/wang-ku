import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/cubit/business_cubit.dart';
import 'package:mobile/cubit/register_cubit.dart';
import 'package:mobile/screens/confirmation_screen.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/screens/loan/loan_verification_first_screen.dart';
import 'package:mobile/screens/loan/loan_verification_second_screen.dart';
import 'package:mobile/screens/loan/loan_verification_third_scree.dart';
import 'package:mobile/screens/network_error_screen.dart';
import 'package:mobile/screens/register/business/help_file_screen.dart';
import 'package:mobile/screens/register/business/register_business_screen.dart';
import 'package:mobile/screens/register/user/signin_screen.dart';
import 'package:mobile/screens/register/user/signup_first_screen.dart';
import 'package:mobile/screens/splash_screens.dart';
import 'package:mobile/utils/route_animations.dart';
import 'package:mobile/utils/route_argument.dart';

import 'screens/register/user/signup_second_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => BusinessCubit(),
        ),
      ],
      child: MaterialApp(
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
              ),
            );
          } else if (settings.name == '/register-business') {
            return RouteAnimations.slide(
                settings, const RegisterBusinessScreen());
          } else if (settings.name == '/loan-first') {
            return RouteAnimations.slide(
                settings, const LoanVerificationFirstScreen());
          } else if (settings.name == '/loan-second') {
            final argument = settings.arguments as Map<String, dynamic>;
            return RouteAnimations.slide(
              settings,
              LoanVerificationSecondScreen(
                name: argument['name'],
                birthplace: argument['birthplace'],
                gender: argument['gender'],
              ),
            );
          } else if (settings.name == '/loan-third') {
            final argument = settings.arguments as Map<String, dynamic>;
            return RouteAnimations.slide(
              settings,
              LoanVerificationThirdScreen(
                name: argument['name'],
                birthplace: argument['birthplace'],
                gender: argument['gender'],
                alamat: argument['alamat'],
                rt: argument['rt'],
                rw: argument['rw'],
                kelurahan: argument['kelurahan'],
                kecamatan: argument['kecamatan'],
                agama: argument['agama'],
              ),
            );
          } else if (settings.name == '/help-file') {
            return RouteAnimations.slide(
                settings,
                HelpFileScreen(
                  text: settings.arguments as String,
                ));
          } else if (settings.name == '/confirmation') {
            final argument = settings.arguments as ConfirmationScreenArgument;
            return RouteAnimations.slide(
              settings,
              ConfirmationScreen(
                information: argument.information,
                hitText: argument.hitText,
                pageDestination: argument.pageDestination,
              ),
            );
          } else if (settings.name == '/network-error') {
            return RouteAnimations.slide(settings, const NetworkErrorScreen());
          } else if (settings.name == '/home') {
            return RouteAnimations.slide(settings, const HomeScreen());
          } else {
            // return RouteAnimations.slide(settings, const SplashScreen());
          }
          return RouteAnimations.slide(settings, const SplashScreen());
        },
      ),
    ),
  );
}
