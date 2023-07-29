import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

class SignupThirdScreen extends StatelessWidget {
  const SignupThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Image.asset(
            'assets/decorations/green_alert_decoration.png',
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset(
              'assets/images/signup_success.png',
              height: 156,
            ),
            const SizedBox(height: 16),
            Text(
              'Akunmu berhasil didaftarkan.',
              textAlign: TextAlign.center,
              style: GlobalTextStyle.paragraph18.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: Text(
                'Masuk Sekarang',
                textAlign: TextAlign.center,
                style: GlobalTextStyle.paragraph16.copyWith(
                  color: GlobalColor.primary[500],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
