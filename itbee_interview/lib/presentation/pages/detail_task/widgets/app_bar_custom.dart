import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/configuration/gen/assets.gen.dart';
import 'package:itbee_interview/localization/strings.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';
import 'package:itbee_interview/utils/navigation.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    super.key,
    required this.themeCurrent,
    required this.activeEdit,
    required this.press,
  });

  final ThemeCubit themeCurrent;
  final bool activeEdit;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
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
                Strings.createNew,
                style: Theme.of(context).textTheme.text18w600.copyWith(
                  color: themeCurrent.appColors.textPrimary,
                ),
              ),
            ),
          ),
          8.horizontalSpace,

          SingleTapDetector(
            onTap: activeEdit ? press : null,
            child: SizedBox(
              height: 20.w,
              width: 20.w,
              child:
                  activeEdit
                      ? Icon(
                        Icons.edit_calendar_rounded,
                        size: 20.w,
                        color: themeCurrent.appColors.textPrimary,
                      )
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
