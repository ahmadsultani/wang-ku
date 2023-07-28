import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final String additionalLabel;
  final TextEditingController controller;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.additionalLabel = '',
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GlobalTextStyle.label12.copyWith(
            fontWeight: FontWeight.w500,
            color: GlobalColor.neutral[900],
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GlobalTextStyle.label12.copyWith(
              color: GlobalColor.neutral[200],
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: GlobalColor.primary[500]!),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: GlobalColor.neutral[900]!),
            ),
          ),
        ),
      ],
    );
  }
}

class GlobalButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final double? width;
  const GlobalButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: GlobalColor.primary[500],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            'Masuk',
            style: GlobalTextStyle.label16.copyWith(
              color: GlobalColor.onPrimaryButton,
            ),
          ),
        ),
      ),
    );
  }
}
