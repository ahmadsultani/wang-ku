import 'package:flutter/material.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/widgets/global_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 32,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Halo, Fathanah', style: GlobalTextStyle.paragraph18),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text('Selamat datang di ',
                          style: GlobalTextStyle.paragraph12),
                      Text('WangKu',
                          style: GlobalTextStyle.paragraph12
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
              const Spacer(),
              const Image(
                  image: AssetImage('assets/images/profile.png'),
                  width: 32,
                  height: 32)
            ],
          ),
          const SizedBox(
            height: 32,
          ),
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
                  const Image(
                    image: AssetImage('assets/images/home_hero.png'),
                    width: 214,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
    );
  }
}
