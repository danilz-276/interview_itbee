import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/injection_container.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';

class CheckBoxItem extends StatelessWidget {
  final bool checkboxValue;

  final String content;
  final VoidCallback onTap;

  CheckBoxItem({
    super.key,
    required this.checkboxValue,
    required this.content,
    required this.onTap,
  });
  final themeCurrent = getIt<ThemeCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleTapDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(color: Colors.transparent),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SingleTapDetector(
                        onTap: onTap,
                        child:
                            (checkboxValue
                                ? Icon(
                                  Icons.radio_button_checked,
                                  color: themeCurrent.appColors.textPrimary,
                                )
                                : Icon(
                                  Icons.radio_button_off,
                                  color: themeCurrent.appColors.textPrimary,
                                )),
                      ),
                      10.25.horizontalSpace,
                      Expanded(
                        child: Text(
                          content,
                          style: Theme.of(
                            context,
                          ).textTheme.text14w500.copyWith(
                            color: themeCurrent.appColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
