import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/utils/route_argument.dart';
import 'package:mobile/widgets/global_widgets.dart';

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
  late TextEditingController statusController;
  late TextEditingController jobController;
  late TextEditingController nationalityController;

  @override
  void initState() {
    statusController = TextEditingController();
    jobController = TextEditingController();
    nationalityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    statusController.dispose();
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
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: GlobalColor.neutral[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_outlined,
                      color: GlobalColor.neutral[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Silahkan Unggah Scan KTP (format jpg/png)\nMaks. 2MB',
                      textAlign: TextAlign.center,
                      style: GlobalTextStyle.paragraph12.copyWith(
                        color: GlobalColor.neutral[300],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomInputField(
                label: 'Status Perkawinan',
                hintText: 'Belum Menikah',
                controller: statusController,
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
              GlobalButton(
                text: 'Verifikasi',
                onTap: () {
                  // TODO: ADD LOAN LOGIC
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/confirmation',
                    (route) => false,
                    arguments: ConfirmationScreenArgument(
                        'KTP-mu berhasil diverifkasi',
                        'Kembali ke beranda',
                        '/home'),
                  );
                  // Navigator.pushNamed(
                  //   context,
                  //   '/loan-second',
                  //   arguments: {
                  //     'name': statusController.text,
                  //     'birthplace': jobController.text,
                  //     'gender': nationalityController.text,
                  //   },
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
