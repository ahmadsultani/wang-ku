import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

class AlertSnackBar extends StatelessWidget {
  final String text;
  const AlertSnackBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        text,
        style: GlobalTextStyle.paragraph14.copyWith(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      backgroundColor: Colors.red,
    );
  }
}

SnackBar alertSnackBar(String text) {
  return SnackBar(
    content: Text(
      text,
      style: GlobalTextStyle.paragraph14.copyWith(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    backgroundColor: Colors.red,
  );
}

SnackBar successSnackBar(String text) {
  return SnackBar(
    content: Text(
      text,
      style: GlobalTextStyle.paragraph14.copyWith(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    backgroundColor: Colors.green,
  );
}

class SuccessSnackBar extends StatelessWidget {
  final String text;
  const SuccessSnackBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        text,
        style: GlobalTextStyle.paragraph14.copyWith(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      backgroundColor: Colors.red,
    );
  }
}
