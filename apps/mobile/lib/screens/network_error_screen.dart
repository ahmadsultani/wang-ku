import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

class NetworkErrorScreen extends StatelessWidget {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Image.asset(
            'assets/decorations/red_alert_decoration.png',
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset(
              'assets/images/network_error.png',
              height: 156,
            ),
            const SizedBox(height: 16),
            Text(
              'Aduh... Jaringanmu terputus nih...',
              textAlign: TextAlign.center,
              style: GlobalTextStyle.paragraph18.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup-first');
              },
              child: Text(
                'Coba lagi',
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
