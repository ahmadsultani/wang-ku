import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

import '../../widgets/global_widgets.dart';

class SignupFirstScreen extends StatefulWidget {
  const SignupFirstScreen({super.key});

  @override
  State<SignupFirstScreen> createState() => _SignupFirstScreenState();
}

class _SignupFirstScreenState extends State<SignupFirstScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                          'Daftar Akun',
                          style: GlobalTextStyle.heading5
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Silahkan lengkapi data dirimu',
                          style: GlobalTextStyle.label12,
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/icons/app_icon.png',
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Name',
                hintText: 'Enter your name',
                controller: nameController,
              ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Email',
                hintText: 'Enter your email',
                controller: emailController,
              ),
              const SizedBox(height: 16),
              CustomInputField(
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 16),
              GlobalButton(
                text: 'Masuk',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
