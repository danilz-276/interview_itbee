import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/configuration/gen/assets.gen.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';

class DayPickerFieldCustom extends StatelessWidget {
  const DayPickerFieldCustom({
    super.key,
    required this.themeCurrent,
    required this.label,
    required this.day,
    required this.press,
    this.isActive = true,
  });

  final ThemeCubit themeCurrent;
  final String label;
  final String day;
  final VoidCallback press;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SingleTapDetector(
      onTap: isActive ? press : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: themeCurrent.appColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: themeCurrent.appColors.textPrimary.withOpacity(.3),
              offset: Offset(0, 1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Opacity(
          opacity: isActive ? 1 : 0.6,

          child: Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 24.w,
                color: themeCurrent.appColors.primaryColor,
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.text10w500.copyWith(
                        color: themeCurrent.appColors.textPrimary,
                      ),
                    ),
                    Text(
                      day,
                      style: Theme.of(context).textTheme.text14w500.copyWith(
                        color: themeCurrent.appColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              12.horizontalSpace,
              SvgPicture.asset(
                MyAssets.svgs.icArrowDown,
                height: 24.w,
                width: 24.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
