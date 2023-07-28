import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final String additionalLabel;

  const InputField({
    super.key,
    required this.label,
    required this.hintText,
    this.additionalLabel = '',
    this.obscureText = false,
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
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: GlobalColor.neutral[900]!),
            ),
          ),
        ),
      ],
    );
  }
}
