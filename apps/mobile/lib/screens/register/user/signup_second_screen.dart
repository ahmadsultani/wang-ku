import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/snackbar.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/cubit/register_cubit.dart';
import 'package:mobile/utils/route_argument.dart';

import '../../../widgets/global_widgets.dart';

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
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
                  number: true,
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
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSignUpSuccess) {
                      final snackBar = successSnackBar('Berhasil membuat akun');
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/confirmation',
                        arguments: ConfirmationScreenArgument(
                            'Akunmu berhasil didaftarkan.',
                            'Masuk sekarang',
                            '/signin'),
                        (route) => false,
                      );
                    } else if (state is RegisterSignUpFailed) {
                      final snackBar = alertSnackBar(state.failure.message);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterSignUpLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: GlobalColor.primary,
                        ),
                      );
                    }
                    return GlobalButton(
                      text: 'Daftar',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (date == null) {
                            final snackBar =
                                alertSnackBar('Tanggal lahir harus diisi');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          if (gender == 'Pilih jenis kelamin') {
                            final snackBar =
                                alertSnackBar('Jenis kelamin harus diisi');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          context.read<RegisterCubit>().onSignup(
                                widget.name,
                                widget.email,
                                widget.password,
                                phoneNumberController.text,
                                date!.millisecondsSinceEpoch,
                                gender,
                              );
                        }
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
      ),
    );
  }
}
