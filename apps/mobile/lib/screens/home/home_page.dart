import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/cubit/register_cubit.dart';
import 'package:mobile/widgets/global_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final bool isPengusaha = true;
  final bool isVerified = true;

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<RegisterCubit>().currentUser;
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
                  Text('Halo, ${currentUser!.name}',
                      style: GlobalTextStyle.paragraph18),
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
                height: 32,
              ),
            ],
          ),
          if (isVerified)
            Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Status Pinjaman:', style: GlobalTextStyle.paragraph12),
                    const SizedBox(
                      width: 6,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFED15D),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text('Sedang diproses',
                          style: GlobalTextStyle.paragraph12),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            )
          else
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
              )
            ],
          ),
          if (isPengusaha)
            Stack(
              children: [
                // Image.asset(
                //   'assets/icons/double_wallet.png',
                //   width: 90,
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            GlobalColor.primary,
                            GlobalColor.neutral[100]!
                          ]),
                      border: Border.all(color: GlobalColor.primary),
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          'Ajukan Pinjaman hingga 500.000.000 dan kembangkan usahamu.',
                          textAlign: TextAlign.right,
                          style: GlobalTextStyle.paragraph18.copyWith(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFFFFFF))),
                      const SizedBox(
                        height: 16,
                      ),
                      if (isVerified)
                        GlobalButton(
                            text: 'Ajukan Pinjaman',
                            secondary: true,
                            onTap: () =>
                                Navigator.pushNamed(context, '/loan-request'))
                      else
                        GlobalButton(
                            text: 'Verifikasi KTP',
                            secondary: true,
                            onTap: () =>
                                Navigator.pushNamed(context, '/loan-first'))
                    ],
                  ),
                ),
              ],
            )
          else
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
                          Navigator.pushNamed(context, '/register-business');
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
