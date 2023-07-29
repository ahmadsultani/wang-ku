import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/widgets/global_widgets.dart';

class DataVerificationSecond extends StatefulWidget {
  const DataVerificationSecond({super.key});

  @override
  State<DataVerificationSecond> createState() => _DataVerificationSecondState();
}

class _DataVerificationSecondState extends State<DataVerificationSecond> {
  late TextEditingController alamatController;
  late TextEditingController rtController;
  late TextEditingController rwController;
  late TextEditingController kelurahanController;
  late TextEditingController kecamatanController;
  late TextEditingController agamaController;

  @override
  void initState() {
    alamatController = TextEditingController();
    rtController = TextEditingController();
    rwController = TextEditingController();
    kelurahanController = TextEditingController();
    kecamatanController = TextEditingController();
    agamaController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    alamatController.dispose();
    rtController.dispose();
    rwController.dispose();
    kelurahanController.dispose();
    kecamatanController.dispose();
    agamaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const GlobalAppBar(
        text: 'Verifikasi Data',
      ),
      body: Form(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                        style: GlobalTextStyle.paragraph16.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '2/3',
                      style: GlobalTextStyle.paragraph16,
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                CustomInputField(
                  controller: alamatController,
                  hintText: 'Alamat',
                  label: 'Alamat',
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        label: 'RT',
                        hintText: '000',
                        controller: rtController,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: CustomInputField(
                        label: 'RW',
                        hintText: '000',
                        controller: rwController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                CustomInputField(
                  label: 'Kel.',
                  hintText: 'Tamangapa',
                  controller: kelurahanController,
                ),
                const SizedBox(height: 9),
                CustomInputField(
                  label: 'Kec.',
                  hintText: 'Tamangapa',
                  controller: kecamatanController,
                ),
                const SizedBox(height: 9),
                CustomInputField(
                  label: 'Agama',
                  hintText: 'Islam',
                  controller: agamaController,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GlobalButton(
                        text: 'Kembali',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: GlobalButton(
                        text: 'Lanjut',
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/loan/data-verification-third');
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
