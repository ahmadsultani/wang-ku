import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/cubit/verify_cubit.dart';
import 'package:mobile/utils/route_argument.dart';
import 'package:mobile/widgets/global_widgets.dart';

import '../../constants/snackbar.dart';

class LoanVerificationThirdScreen extends StatefulWidget {
  final String name;
  final String birthplace;
  final String gender;
  final String alamat;
  final String rt;
  final String rw;
  final String kelurahan;
  final String kecamatan;
  final String agama;
  const LoanVerificationThirdScreen({
    super.key,
    required this.name,
    required this.birthplace,
    required this.gender,
    required this.alamat,
    required this.rt,
    required this.rw,
    required this.kelurahan,
    required this.kecamatan,
    required this.agama,
  });

  @override
  State<LoanVerificationThirdScreen> createState() =>
      _LoanVerificationThirdScreenState();
}

class _LoanVerificationThirdScreenState
    extends State<LoanVerificationThirdScreen> {
  late TextEditingController nikController;
  late TextEditingController jobController;
  late TextEditingController nationalityController;

  @override
  void initState() {
    nikController = TextEditingController();
    jobController = TextEditingController();
    nationalityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nikController.dispose();
    jobController.dispose();
    nationalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const GlobalAppBar(text: 'Verifikasi KTP'),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Informasi Pelaku Usaha',
                      style: GlobalTextStyle.paragraph16
                          .copyWith(color: GlobalColor.primary),
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: GlobalColor.primary,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'informasi Usaha',
                      style: GlobalTextStyle.paragraph16
                          .copyWith(color: GlobalColor.primary),
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: GlobalColor.primary,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Verifikasi KTP',
                      style: GlobalTextStyle.paragraph16.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '3/3',
                    style: GlobalTextStyle.paragraph16,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              CustomInputField(
                label: 'NIK',
                hintText: 'NIK',
                controller: nikController,
              ),
              const SizedBox(height: 9),
              CustomInputField(
                label: 'Pekerjaan',
                hintText: 'Pelajar/Mahasiswa',
                controller: jobController,
              ),
              const SizedBox(height: 9),
              CustomInputField(
                label: 'Kewarganegaraan',
                hintText: 'WNI',
                controller: nationalityController,
              ),
              const SizedBox(height: 24),
              BlocConsumer<VerifyCubit, VerifyState>(
                listener: (context, state) {
                  if (state is VerifySuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/confirmation',
                      (route) => false,
                      arguments: ConfirmationScreenArgument(
                        'KTP-mu berhasil diverifkasi',
                        'Kembali ke beranda',
                        '/home',
                      ),
                    );
                  } else if (state is VerifyFailed) {
                    final snackBar = alertSnackBar(state.failure.message);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state is VerifyLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: GlobalColor.primary,
                      ),
                    );
                  }
                  return GlobalButton(
                    text: 'Verifikasi',
                    onTap: () {
                      context.read<VerifyCubit>().onVerifyUser(
                          '', nikController.text, widget.birthplace);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
