import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';

class TitleWithNumber extends StatelessWidget {
  const TitleWithNumber({
    super.key,
    required this.themeCurrent,
    required this.title,
    required this.number,
    this.press,
  });

  final ThemeCubit themeCurrent;
  final String title;
  final int number;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.text20w600.copyWith(
                    color: themeCurrent.appColors.textPrimary,
                  ),
                ),
                4.horizontalSpace,
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // ignore: deprecated_member_use
                    color: themeCurrent.appColors.primaryColor.withOpacity(.3),
                  ),
                  child: Text(
                    '$number',
                    style: Theme.of(context).textTheme.text12w400.copyWith(
                      color: themeCurrent.appColors.progressPurple,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (press != null) ...[
            8.horizontalSpace,

            IconButton(
              onPressed: press,
              icon: Icon(Icons.filter_alt),
              iconSize: 20.w,
            ),
          ],
        ],
      ),
    );
  }
}
