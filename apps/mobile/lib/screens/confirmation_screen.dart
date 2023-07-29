import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

class ConfirmationScreen extends StatelessWidget {
  final String information;
  final String hitText;
  final String pageDestination;
  const ConfirmationScreen({
    super.key,
    required this.information,
    required this.hitText,
    required this.pageDestination,
  });

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
                  information,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyle.paragraph18.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      pageDestination,
                      (route) => false,
                    );
                  },
                  child: Text(
                    hitText,
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
