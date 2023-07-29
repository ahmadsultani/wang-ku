import 'package:flutter/material.dart';
import 'package:mobile/constants/snackbar.dart';
import 'package:mobile/constants/styles.dart';

import '../../../widgets/global_widgets.dart';

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
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
                      'assets/icons/splash_icon.png',
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Image.asset(
                  'assets/images/add_profile.png',
                  width: 50,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  label: 'Name',
                  hintText: 'Enter your name',
                  additionalLabel: '*sesuai KTP',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 8,
                      decoration: BoxDecoration(
                        color: GlobalColor.neutral[700],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: GlobalColor.neutral[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GlobalButton(
                  text: 'Selanjutnya',
                  onTap: () {
                    print(passwordController.text);
                    print(nameController.text);
                    if (_formKey.currentState!.validate()) {
                      if (passwordController.text.length < 6) {
                        final snackBar = alertSnackBar(
                            'Panjang password minimal 6 karakter');
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      Navigator.pushNamed(
                        context,
                        '/signup-second',
                        arguments: {
                          'name': nameController.text,
                          'email': emailController.text,
                          'password': passwordController.text,
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah memiliki akun? ',
                      style: GlobalTextStyle.label12,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: Text(
                        'Masuk',
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
      ),
    );
  }
}
