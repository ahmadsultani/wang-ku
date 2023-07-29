import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

import '../../../widgets/global_widgets.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Masuk',
                          style: GlobalTextStyle.heading5
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Masukkan informasi masukmu',
                          style: GlobalTextStyle.label12,
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/icons/splash_icon.png',
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Email',
                hintText: 'Enter your email',
                controller: emailController,
              ),
              const SizedBox(height: 8),
              CustomInputField(
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 16),
              GlobalButton(
                text: 'Masuk',
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum memiliki akun? ',
                    style: GlobalTextStyle.label12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup-first');
                    },
                    child: Text(
                      'Daftar',
                      style: GlobalTextStyle.label12.copyWith(
                        color: GlobalColor.primary[500],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
