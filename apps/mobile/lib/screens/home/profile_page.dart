import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        const SizedBox(height: 32),
        Row(
          children: [
            Text('Nurunnisa Fathanah',
                style: GlobalTextStyle.paragraph18
                    .copyWith(fontWeight: FontWeight.w600)),
            const Spacer(),
            const Image(
                image: AssetImage('assets/images/profile.png'),
                width: 32,
                height: 32)
          ],
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [GlobalColor.primary, GlobalColor.onPrimaryButton]),
              border: Border.all(color: GlobalColor.primary),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Limit pinjaman',
                style: GlobalTextStyle.label16
                    .copyWith(color: const Color(0xFFFFFFFF))),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Rp. 0/500.000.000',
              style: GlobalTextStyle.heading3.copyWith(
                  fontWeight: FontWeight.w700, color: const Color(0xFFFFFFFF)),
            ),
          ]),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
              border: Border.all(color: GlobalColor.primary),
              borderRadius: BorderRadius.circular(4)),
          child: Row(children: [
            Text(
              'Akun',
              style: GlobalTextStyle.paragraph16
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              '-',
              style: GlobalTextStyle.paragraph16
                  .copyWith(fontWeight: FontWeight.w700),
            )
          ]),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: GlobalColor.primary[400]!),
              borderRadius: BorderRadius.circular(4)),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                children: [
                  Text(
                    'Nama Lengkap',
                    style: GlobalTextStyle.paragraph12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: GlobalColor.neutral[900]),
                  ),
                  const Spacer(),
                  Text(
                    'Nurunnisa Fathanah',
                    style: GlobalTextStyle.paragraph12
                        .copyWith(color: GlobalColor.neutral[600]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                children: [
                  Text(
                    'Email',
                    style: GlobalTextStyle.paragraph12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: GlobalColor.neutral[900]),
                  ),
                  const Spacer(),
                  Text(
                    'fath@gmail.com',
                    style: GlobalTextStyle.paragraph12
                        .copyWith(color: GlobalColor.neutral[600]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                children: [
                  Text(
                    'No. Telepon',
                    style: GlobalTextStyle.paragraph12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: GlobalColor.neutral[900]),
                  ),
                  const Spacer(),
                  Text(
                    '0851-1204-3567',
                    style: GlobalTextStyle.paragraph12
                        .copyWith(color: GlobalColor.neutral[600]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                children: [
                  Text(
                    'Tanggal Lahir',
                    style: GlobalTextStyle.paragraph12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: GlobalColor.neutral[900]),
                  ),
                  const Spacer(),
                  Text(
                    '08 Juli 2002',
                    style: GlobalTextStyle.paragraph12
                        .copyWith(color: GlobalColor.neutral[600]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                children: [
                  Text(
                    'Kata Sandi',
                    style: GlobalTextStyle.paragraph12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: GlobalColor.neutral[900]),
                  ),
                  const Spacer(),
                  Text(
                    '',
                    style: GlobalTextStyle.paragraph12
                        .copyWith(color: GlobalColor.neutral[600]),
                  ),
                ],
              ),
            )
          ]),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
              border: Border.all(color: GlobalColor.primary),
              borderRadius: BorderRadius.circular(4)),
          child: Row(children: [
            Text(
              'Informasi Usaha',
              style: GlobalTextStyle.paragraph16
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              '+',
              style: GlobalTextStyle.paragraph16
                  .copyWith(fontWeight: FontWeight.w700),
            )
          ]),
        ),
      ]),
    );
  }
}
