import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/constants/styles.dart';
import 'package:mobile/cubit/profile_cubit.dart';
import 'package:mobile/cubit/register_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileCubit>().onGetProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<RegisterCubit>().currentUser;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        const SizedBox(height: 32),
        Row(
          children: [
            Text(user!.name,
                style: GlobalTextStyle.paragraph18
                    .copyWith(fontWeight: FontWeight.w600)),
            const Spacer(),
            const Image(
              image: AssetImage('assets/images/profile.png'),
              width: 32,
              height: 32,
            ),
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
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is ProfileGetSuccess) {
                  return Text(
                    'Rp. ${state.profile.lendTotal}/${state.profile.lendLimit}',
                    style: GlobalTextStyle.heading3.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFFFFFF)),
                  );
                }
                return Text(
                  'Rp. -/-',
                  style: GlobalTextStyle.heading3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF)),
                );
              },
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
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProfileGetSuccess) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
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
                            state.profile.name,
                            style: GlobalTextStyle.paragraph12
                                .copyWith(color: GlobalColor.neutral[600]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
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
                            state.profile.email,
                            style: GlobalTextStyle.paragraph12
                                .copyWith(color: GlobalColor.neutral[600]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
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
                            state.profile.number,
                            style: GlobalTextStyle.paragraph12
                                .copyWith(color: GlobalColor.neutral[600]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
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
                            DateFormat('d MMMM yyyy')
                                .format(state.profile.birthdate),
                            style: GlobalTextStyle.paragraph12
                                .copyWith(color: GlobalColor.neutral[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container(
                height: 176,
                child: Center(
                  child: CircularProgressIndicator(
                    color: GlobalColor.primary,
                  ),
                ),
              );
            },
          ),
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
