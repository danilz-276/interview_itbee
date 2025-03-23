import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/injection_container.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IndicatorPercentCustom extends StatelessWidget {
  const IndicatorPercentCustom({
    super.key,
    required this.percent,
    this.textStyle,
    this.size,
    this.width,
    this.color,
  });
  final double percent;
  final TextStyle? textStyle;
  final double? size;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final themeCurrent = getIt<ThemeCubit>();

    return CircularPercentIndicator(
      radius: size ?? 40.r,
      lineWidth: width ?? 8.w,
      animation: true,
      percent: percent,
      center: Text(
        "${(percent * 100).toInt()}%",
        style:
            textStyle ??
            Theme.of(context).textTheme.text16w600.copyWith(
              color: themeCurrent.appColors.taskCardBorder,
            ),
      ),

      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color ?? themeCurrent.appColors.taskCardBorder,
      backgroundColor: (color ?? themeCurrent.appColors.taskCardBorder)
          // ignore: deprecated_member_use
          .withOpacity(.3),
    );
  }
}
