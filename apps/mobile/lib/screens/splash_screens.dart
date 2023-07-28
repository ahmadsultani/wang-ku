import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () { 
      Navigator.pushNamed(context, '/signup-first');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold());
  }
}