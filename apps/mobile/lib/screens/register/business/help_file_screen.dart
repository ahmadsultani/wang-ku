import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/widgets/global_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpFileScreen extends StatelessWidget {
  final String text;
  const HelpFileScreen({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kamu belum memiliki $text?',
                style: GlobalTextStyle.heading5,
              ),
              const SizedBox(height: 8),
              Text(
                'Tenang, biar kami yang bantu',
                style: GlobalTextStyle.label16,
              ),
              const SizedBox(height: 32),
              Image.asset(
                'assets/images/help_center.png',
                width: 240,
              ),
              const SizedBox(height: 32),
              GlobalButton(
                width: 140,
                text: 'Hubungi Kami',
                onTap: () async {
                  const url = 'https://wa.me/+6282193179080';
                  // await launchUrl(
                  //     Uri.parse('https://wa.me/?text=+6281355938355'));
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalNonBrowserApplication);
                  } else {
                    throw 'Cant launch';
                  }
                },
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
                child: Text(
                  'Kembali ke beranda',
                  style: GlobalTextStyle.paragraph12
                      .copyWith(color: GlobalColor.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
