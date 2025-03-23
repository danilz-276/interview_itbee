import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/configuration/gen/assets.gen.dart';
import 'package:itbee_interview/injection_container.dart';
import 'package:itbee_interview/localization/strings.dart';
import 'package:itbee_interview/presentation/pages/setting/cubit/setting_cubit.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';
import 'package:itbee_interview/utils/navigation.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final themeCurrent = getIt<ThemeCubit>();
  late SettingCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = SettingCubit();
    getData();
  }

  getData() {
    cubit.changeDark(themeCurrent.isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          var cubit = context.read<SettingCubit>();
          return Scaffold(
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 8.h,
                    top: MediaQuery.of(context).viewPadding.top + 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: themeCurrent.appColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: themeCurrent.appColors.textPrimary.withOpacity(
                          .3,
                        ),
                        offset: Offset(0, 1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SingleTapDetector(
                        onTap: () {
                          NavigationUtils.popPage(context);
                        },
                        child: SvgPicture.asset(
                          MyAssets.svgs.icArrowLeft,
                          height: 20.w,
                          width: 20.w,
                          colorFilter: ColorFilter.mode(
                            themeCurrent.appColors.textPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: Center(
                          child: Text(
                            Strings.settings,
                            style: Theme.of(
                              context,
                            ).textTheme.text18w600.copyWith(
                              color: themeCurrent.appColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      SizedBox(width: 20.w),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        12.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                Strings.darkMode,
                                style: Theme.of(
                                  context,
                                ).textTheme.text15w500.copyWith(
                                  color: themeCurrent.appColors.textPrimary,
                                ),
                              ),
                            ),
                            Switch(
                              value: cubit.isDark,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                themeCurrent.toggleTheme().then((a) {
                                  cubit.changeDark(themeCurrent.isDarkMode);
                                });
                                // This is called when the user toggles the switch.
                              },
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                Strings.notifications,
                                style: Theme.of(
                                  context,
                                ).textTheme.text15w500.copyWith(
                                  color: themeCurrent.appColors.textPrimary,
                                ),
                              ),
                            ),
                            Switch(
                              value: cubit.isNoti,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                cubit.changeNoti();
                                // This is called when the user toggles the switch.
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
