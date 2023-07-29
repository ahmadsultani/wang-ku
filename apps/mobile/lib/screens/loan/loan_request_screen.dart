import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/widgets/global_widgets.dart';

class LoanRequestScreen extends StatefulWidget {
  const LoanRequestScreen({super.key});

  @override
  State<LoanRequestScreen> createState() => _LoanRequestScreenState();
}

class _LoanRequestScreenState extends State<LoanRequestScreen> {
  late TextEditingController limitController;
  late TextEditingController jumlahController;
  late TextEditingController bankController;
  late TextEditingController noRekController;
  late TextEditingController namaRekController;

  @override
  void initState() {
    limitController = TextEditingController();
    jumlahController = TextEditingController();
    bankController = TextEditingController();
    noRekController = TextEditingController();
    namaRekController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    limitController.dispose();
    jumlahController.dispose();
    bankController.dispose();
    noRekController.dispose();
    namaRekController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const GlobalAppBar(
        text: 'Pegajuan Pinjaman',
      ),
      body: Form(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 24),
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
              Text(
                'Detail Pengajuan Pinjaman',
                style: GlobalTextStyle.paragraph16
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              CustomInputField(
                label: 'Limit Pinjaman',
                hintText: '500.000.000',
                enabled: false,
                controller: limitController,
              ),
              const SizedBox(height: 9),
              CustomInputField(
                label: 'Jumlah Pinjaman',
                hintText: '100.000.000',
                controller: jumlahController,
              ),
              const SizedBox(height: 9),
              CustomInputField(
                label: 'Bank',
                hintText: 'Pilih Bank',
                enabled: false,
                controller: bankController,
              ),
              const SizedBox(height: 9),
              CustomInputField(
                label: 'Nomor Rekening',
                hintText: 'xxxx xx xxxxxx xx x',
                controller: noRekController,
              ),
              const SizedBox(height: 9),
              CustomInputField(
                label: 'Rekening a.n',
                hintText: 'Nurunnisa Fathanah',
                controller: namaRekController,
              ),
              const SizedBox(height: 24),
              GlobalButton(
                text: 'Selanjutnya',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/loan-success',
                    arguments: {
                      'limit': limitController.text,
                      'jumlah': jumlahController.text,
                      'bank': bankController.text,
                      'noRek': noRekController.text,
                      'namaRek': namaRekController.text,
                    },
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
