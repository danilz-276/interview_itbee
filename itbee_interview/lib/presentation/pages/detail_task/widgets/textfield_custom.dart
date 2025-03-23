import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    required this.themeCurrent,
    required this.label,
    this.maxline,
    this.isCenter = true,
    required this.controller,
    this.isActive = true,
  });

  final ThemeCubit themeCurrent;
  final TextEditingController controller;
  final String label;
  final int? maxline;
  final bool isCenter;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            TextField(
              controller: controller,

              textAlignVertical:
                  isCenter ? TextAlignVertical.center : TextAlignVertical.top,
              enableSuggestions: false,
              style: Theme.of(context).textTheme.text14w500.copyWith(
                color: themeCurrent.appColors.textPrimary,
              ),

              maxLines: maxline,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: Theme.of(context).textTheme.text10w500.copyWith(
                  color: themeCurrent.appColors.textPrimary,
                ),
                enabled: isActive,

                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                // alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
