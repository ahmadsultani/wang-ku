import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/constants/styles.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final String additionalLabel;
  final TextEditingController controller;
  final bool number;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.additionalLabel = '',
    this.obscureText = false,
    required this.controller,
    this.number = false,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool? hide;

  @override
  void initState() {
    if (widget.obscureText) {
      hide = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: GlobalTextStyle.label16.copyWith(
                  fontWeight: FontWeight.w500,
                  color: GlobalColor.neutral[900],
                ),
              ),
            ),
            widget.additionalLabel.isNotEmpty
                ? Text(
                    widget.additionalLabel,
                    style: GlobalTextStyle.label12.copyWith(
                      fontWeight: FontWeight.w500,
                      color: GlobalColor.neutral[500],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(height: 4),
        TextField(
          obscureText: hide ?? false,
          keyboardType: widget.number ? TextInputType.number : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GlobalTextStyle.label12.copyWith(
              color: GlobalColor.neutral[200],
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        hide = !(hide!);
                      });
                    },
                    icon: Icon(
                      hide!
                          ? Icons.remove_red_eye_rounded
                          : Icons.visibility_off_outlined,
                      color: GlobalColor.neutral[900],
                    ),
                  )
                : null,
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

class CustomDateField extends StatefulWidget {
  final void Function(DateTime newDate) onChange;
  DateTime? date;

  CustomDateField({
    super.key,
    required this.date,
    required this.onChange,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Tanggal Lahir',
                style: GlobalTextStyle.label16.copyWith(
                  fontWeight: FontWeight.w500,
                  color: GlobalColor.neutral[900],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            widget.date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(900),
              lastDate: DateTime(2050),
            );
            widget.onChange(widget.date!);
            setState(() {});
          },
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: GlobalColor.neutral[900]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                widget.date == null
                    ? Text(
                        'dd-mm-yy',
                        style: GlobalTextStyle.label16
                            .copyWith(color: GlobalColor.neutral[200]),
                      )
                    : Text(
                        DateFormat('dd-MM-yyyy').format(widget.date!),
                        style: GlobalTextStyle.label16,
                      ),
                const Expanded(child: SizedBox()),
                const Icon(Icons.calendar_month),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropDown extends StatefulWidget {
  String? text;
  final List<DropdownMenuItem<String>> items;
  final void Function(String? value) onChange;

  CustomDropDown({
    super.key,
    required this.text,
    required this.onChange,
    required this.items,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  // @override
  // void initState() {
  //   final index = widget.items.indexWhere((item) => item.value == widget.text);
  //   widget.items[index] = DropdownMenuItem(
  //         value: widget.items[index].value,
  //         enabled: false,
  //         child: Container(
  //           color: GlobalColor.neutral[900],
  //           child: Text(
  //             widget.items[index].value!,
  //             style: GlobalTextStyle.label16
  //                 .copyWith(color: GlobalColor.neutral[200]),
  //           ),
  //         ),
  //       );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Jenis Kelamin',
                style: GlobalTextStyle.label16.copyWith(
                  fontWeight: FontWeight.w500,
                  color: GlobalColor.neutral[900],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          hint: Text(
            'Pilih jenis kelamin',
            style: GlobalTextStyle.label16
                .copyWith(color: GlobalColor.neutral[200]),
          ),
          borderRadius: BorderRadius.circular(5),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: GlobalColor.neutral[900]!),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: GlobalColor.neutral[900]!),
            ),
          ),
          items: widget.items,
          onChanged: (value) {
            setState(() {
              widget.onChange(value);
            });
          },
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
            text,
            style: GlobalTextStyle.label16.copyWith(
              color: GlobalColor.onPrimaryButton,
            ),
          ),
        ),
      ),
    );
  }
}
