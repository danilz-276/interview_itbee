import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/localization/strings.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/button_widget.dart';
import 'package:itbee_interview/presentation/widgets/indicator_percent_custom.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';

class CardTotalDoing extends StatelessWidget {
  const CardTotalDoing({
    super.key,
    required ThemeCubit themeCurrent,
    required this.percent,
    required this.press,
  }) : _themeCurrent = themeCurrent;

  final ThemeCubit _themeCurrent;
  final double percent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: _themeCurrent.appColors.primaryColor,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.yourWorkToday,
                        style: Theme.of(context).textTheme.text16w600.copyWith(
                          color: _themeCurrent.appColors.taskCardBorder,
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          ButtonWidget(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            radius: 12.r,
                            press: press,
                            activeTitle: Strings.viewTasks,
                            activeTextColor:
                                _themeCurrent.appColors.primaryColor,
                            activeColor: _themeCurrent.appColors.taskCardBorder,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IndicatorPercentCustom(percent: percent),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
              ),
            ],
          ),
          Positioned(
            top: 12.h,
            right: 16.w,
            child: SingleTapDetector(
              onTap: press,
              child: Container(
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: _themeCurrent.appColors.taskCardBorder.withOpacity(.3),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.more_horiz_outlined,
                  color: _themeCurrent.appColors.taskCardBorder,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
