import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubit/business_cubit.dart';
import 'package:mobile/utils/route_argument.dart';
import 'package:mobile/widgets/global_widgets.dart';

import '../../../constants/snackbar.dart';
import '../../../constants/styles.dart';

class RegisterBusinessScreen extends StatefulWidget {
  const RegisterBusinessScreen({super.key});

  @override
  State<RegisterBusinessScreen> createState() => _RegisterBusinessScreenState();
}

class _RegisterBusinessScreenState extends State<RegisterBusinessScreen> {
  late TextEditingController businessNameController;
  late TextEditingController npwpController;
  late TextEditingController nibController;
  late TextEditingController addressController;
  late TextEditingController incomeController;
  late TextEditingController outcomeController;
  String category = 'Pilih kategori usaha';
  late List<DropdownMenuItem<String>> categoryItems;
  void onCategoryChange(String? value) {
    setState(() {
      category = value!;
    });
  }

  List<String> categoryNames = [
    'Grosir',
    'Material',
    'Manufaktur',
    'Kuliner',
    'Jasa',
    'Perangkat keras',
    'Lainnya',
  ];

  @override
  void initState() {
    categoryItems = [
      DropdownMenuItem(
        value: 'Pilih kategori usaha',
        enabled: false,
        child: Container(
          child: Text(
            'Pilih kategori usaha',
            style: GlobalTextStyle.label16
                .copyWith(color: GlobalColor.neutral[200]),
          ),
        ),
      ),
      ...categoryNames.map(
        (item) => DropdownMenuItem(
          value: item,
          child: Container(
            child: Text(
              item,
              style: GlobalTextStyle.label16,
            ),
          ),
        ),
      ),
    ];
    businessNameController = TextEditingController();
    npwpController = TextEditingController();
    nibController = TextEditingController();
    addressController = TextEditingController();
    incomeController = TextEditingController();
    outcomeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    businessNameController.dispose();
    npwpController.dispose();
    nibController.dispose();
    addressController.dispose();
    incomeController.dispose();
    outcomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: GlobalAppBar(
          text: 'Pendaftaran Usaha',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              children: [
                CustomInputField(
                  label: 'Nama Usaha',
                  hintText: 'RM ALHAMDULILLAH',
                  controller: businessNameController,
                ),
                const SizedBox(height: 8),
                CustomDropDown(
                  text: 'Kategori Usaha',
                  onChange: onCategoryChange,
                  items: categoryItems,
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  label: 'No. NPWP',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  controller: npwpController,
                  additionalLabel: 'Belum punya NPWP?',
                  additionaLabelGreen: true,
                  onAdditionalLabelTap: () {
                    Navigator.pushNamed(context, '/help-file',
                        arguments: 'NPWP');
                  },
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  label: 'NIB',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  controller: nibController,
                  additionalLabel: 'Belum punya NIB?',
                  additionaLabelGreen: true,
                  onAdditionalLabelTap: () {
                    Navigator.pushNamed(context, '/help-file',
                        arguments: 'NIB');
                  },
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  label: 'Alamat',
                  hintText: 'Jl Poros Malino',
                  controller: addressController,
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  label: 'Pemasukan Per Bulan',
                  hintText: 'Rp. 500.000.000',
                  controller: incomeController,
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  label: 'Pengeluaran Per Bulan',
                  hintText: 'Rp. 400.000.000',
                  controller: outcomeController,
                ),
                const SizedBox(height: 15),
                BlocConsumer<BusinessCubit, BusinessState>(
                  listener: (context, state) {
                    if (state is BusinessRegisterSuccess) {
                      Navigator.pushNamed(
                        context,
                        '/confirmation',
                        arguments: ConfirmationScreenArgument(
                          'Pendaftaranmu berhasil diproses',
                          'Kembali ke beranda',
                          '/home',
                        ),
                      );
                    } else if (state is BusinessRegisterFailed) {
                      final snackBar = alertSnackBar(state.failure.message);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    if (state is BusinessRegisterLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: GlobalColor.primary,
                        ),
                      );
                    }
                    return GlobalButton(
                      text: 'Daftar',
                      onTap: () {
                        context.read<BusinessCubit>().onRegisterBusiness(
                              businessNameController.text,
                              category,
                              npwpController.text,
                              nibController.text,
                              '',
                              addressController.text,
                              '',
                              outcomeController.text,
                              incomeController.text,
                            );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
