import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/configuration/gen/assets.gen.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CardInProgress extends StatelessWidget {
  const CardInProgress({
    super.key,
    required this.themeCurrent,
    required this.groupName,
    required this.title,
    required this.percent,
    required this.color,
    required this.press,
  });

  final ThemeCubit themeCurrent;
  final String groupName;
  final String title;
  final double percent;
  final Color color;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SingleTapDetector(
      onTap: press,
      child: Container(
        width: 200.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          // ignore: deprecated_member_use
          color: themeCurrent.appColors.progressBlue.withOpacity(.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    groupName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.text12w300.copyWith(
                      color: themeCurrent.appColors.textPrimary,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  MyAssets.svgs.icBell,
                  height: 16.w,
                  width: 16.w,
                ),
              ],
            ),
            12.verticalSpace,
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.text13w500.copyWith(
                color: themeCurrent.appColors.textPrimary,
              ),
            ),
            20.verticalSpace,

            LinearPercentIndicator(
              animation: true,
              lineHeight: 8.h,
              width: 176.w,
              barRadius: Radius.circular(8.r),
              animationDuration: 500,
              percent: percent,
              progressColor: color,
              backgroundColor: themeCurrent.appColors.backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
