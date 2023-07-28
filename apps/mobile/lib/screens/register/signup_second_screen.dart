import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

import '../../widgets/global_widgets.dart';

class SignupSecondScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  const SignupSecondScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.password});

  @override
  State<SignupSecondScreen> createState() => _SignupSecondScreenState();
}

class _SignupSecondScreenState extends State<SignupSecondScreen> {
  late TextEditingController phoneNumberController;
  String gender = 'Pilih jenis kelamin';
  final List<DropdownMenuItem<String>> genderItems = [
    DropdownMenuItem(
      value: 'Pilih jenis kelamin',
      enabled: false,
      child: Container(
        child: Text(
          'Pilih jenis kelamin',
          style:
              GlobalTextStyle.label16.copyWith(color: GlobalColor.neutral[200]),
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Perempuan',
      child: Container(
        child: Text(
          'Perempuan',
          style: GlobalTextStyle.label16,
        ),
      ),
    ),
    DropdownMenuItem(
      value: 'Laki-laki',
      child: Container(
        child: Text(
          'Laki-laki',
          style: GlobalTextStyle.label16,
        ),
      ),
    ),
  ];

  void genderOnChange(String? value) {
    setState(() {
      gender = value!;
    });
    print(gender);
  }

  DateTime? date;

  void onChangeDate(DateTime newDate) {
    date = newDate;
  }

  @override
  void initState() {
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

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
              CustomInputField(
                label: 'No. Telepon',
                hintText: '08xx xxxx xxxxx',
                controller: phoneNumberController,
              ),
              const SizedBox(height: 16),
              CustomDateField(date: date, onChange: onChangeDate),
              const SizedBox(height: 16),
              CustomDropDown(
                text: gender,
                onChange: genderOnChange,
                items: genderItems,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: GlobalColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 32,
                    height: 8,
                    decoration: BoxDecoration(
                      color: GlobalColor.neutral[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GlobalButton(
                text: 'Daftar',
                onTap: () {
                  print(date);
                  Navigator.pushNamed(
                    context,
                    '/signup-third', // TODO
                    arguments: {
                      'name': phoneNumberController,
                      // 'email': emailController,
                      // 'password': passwordController,
                    },
                  );
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
    );
  }
}
