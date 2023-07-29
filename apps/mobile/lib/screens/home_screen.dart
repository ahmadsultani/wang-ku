import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/widgets/global_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: GlobalAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: GlobalColor.primary,
                  border: Border.all(color: GlobalColor.primary),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Limit pinjaman',
                        style: GlobalTextStyle.label16
                            .copyWith(color: const Color(0xFFFFFFFF))),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Rp. 0/500.000.000',
                      style: GlobalTextStyle.heading3.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFFFFF)),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('Berikut arus kas mu bulan ini.'),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: GlobalColor.primary[50],
                        border: Border.all(color: GlobalColor.primary),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pemasukan',
                          style: GlobalTextStyle.label12,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Rp. 0',
                          style: GlobalTextStyle.paragraph12
                              .copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: const Color(0xFFEFCCCC),
                        border: Border.all(color: const Color(0xFFB10000)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pengeluaran',
                          style: GlobalTextStyle.label12,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Rp. 0',
                          style: GlobalTextStyle.paragraph12
                              .copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Kamu belum mendaftarkan usahamu nih.',
                      style: GlobalTextStyle.paragraph12,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GlobalButton(
                        text: "Daftar Sekarang",
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        width: MediaQuery.of(context).size.width / 2)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: GlobalColor.primary,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/transaction');
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    ));
  }
}
