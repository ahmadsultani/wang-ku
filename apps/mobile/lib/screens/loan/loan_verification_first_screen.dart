import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/widgets/global_widgets.dart';

class LoanVerificationFirstScreen extends StatefulWidget {
  const LoanVerificationFirstScreen({super.key});

  @override
  State<LoanVerificationFirstScreen> createState() =>
      _LoanVerificationFirstScreenState();
}

class _LoanVerificationFirstScreenState
    extends State<LoanVerificationFirstScreen> {
  late TextEditingController nameController;
  late TextEditingController birthplaceController;
  late TextEditingController genderController;
//       File? _image;
// final picker = ImagePicker();
// //Image Picker function to get image from gallery
// Future getImageFromGallery() async {
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//   setState(() {
//     if (pickedFile != null) {
//       _image = File(pickedFile.path);
//     }
//   });
// }

// //Image Picker function to get image from camera
// Future getImageFromCamera() async {
//   final pickedFile = await picker.pickImage(source: ImageSource.camera);

//   setState(() {
//     if (pickedFile != null) {
//       _image = File(pickedFile.path);
//     }
//   });
// }

// Future showOptions() async {
//   showCupertinoModalPopup(
//     context: context,
//     builder: (context) => CupertinoActionSheet(
//       actions: [
//         CupertinoActionSheetAction(
//           child: Text('Photo Gallery'),
//           onPressed: () {
//             // close the options modal
//             Navigator.of(context).pop();
//             // get image from gallery
//             getImageFromGallery();
//           },
//         ),
//         CupertinoActionSheetAction(
//           child: Text('Camera'),
//           onPressed: () {
//             // close the options modal
//             Navigator.of(context).pop();
//             // get image from camera
//             getImageFromCamera();
//           },
//         ),
//       ],
//     ),
//   );
// }

  @override
  void initState() {
    nameController = TextEditingController();
    birthplaceController = TextEditingController();
    genderController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthplaceController.dispose();
    genderController.dispose();
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
                    '1/3',
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
                label: 'Nama Lengkap',
                hintText: 'Nurunnisa Fathanah',
                controller: nameController,
              ),
              const SizedBox(height: 9),
              CustomInputField(
                label: 'Tempat Lahir',
                hintText: 'Makassar',
                controller: birthplaceController,
              ),
              const SizedBox(height: 9),
              CustomInputField(
                label: 'Jenis Kelamin',
                hintText: 'Perempuan',
                controller: genderController,
              ),
              const SizedBox(height: 24),
              GlobalButton(
                text: 'Selanjutnya',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/loan-second',
                    arguments: {
                      'name': nameController.text,
                      'birthplace': birthplaceController.text,
                      'gender': genderController.text,
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
