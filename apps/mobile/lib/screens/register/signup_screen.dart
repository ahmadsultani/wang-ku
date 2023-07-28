import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/widgets/input_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                            Text('Daftar Akun',
                                style: GlobalTextStyle.heading5
                                    .copyWith(fontWeight: FontWeight.w700)),
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
                  const InputField(
                    label: 'Name',
                    hintText: 'Enter your name',
                  ),
                  const SizedBox(height: 16),
                  const InputField(
                    label: 'Email',
                    hintText: 'Enter your email',
                  ),
                  const SizedBox(height: 16),
                  const InputField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Implement registration logic here
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            )));
  }
}
