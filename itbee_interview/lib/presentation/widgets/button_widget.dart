import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itbee_interview/configuration/app_styles.dart';
import 'package:itbee_interview/injection_container.dart';
import 'package:itbee_interview/presentation/pages/theme/theme_cubit.dart';
import 'package:itbee_interview/presentation/widgets/singletap_detector.dart';
import 'package:itbee_interview/utils/const.dart';

class ButtonWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final BorderRadiusGeometry? activeBorderRadius;
  final Border? activeBorder;
  final Alignment? activeAlignment;
  final Color? activeColor;
  final Color? activeTextColor;
  final TextStyle? activeTextStyle;
  final String? activeTitle;
  final Gradient? activeGradient;

  final BorderRadiusGeometry? inActiveBorderRadius;
  final Border? inActiveBorder;
  final Alignment? inActiveAlignment;
  final Color? inActiveColor;
  final Color? inActiveTextColor;
  final TextStyle? inActiveTextStyle;
  final String? inActiveTitle;
  final Gradient? inActiveGradient;

  final Widget? activeWidget;
  final Widget? inActiveWidget;

  final bool isActive;
  final bool? haveGradient;
  final bool isSecondary;
  final VoidCallback press;
  final EdgeInsets? padding;
  final bool isFullSize;

  ButtonWidget({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.activeBorderRadius,
    this.activeBorder,
    this.activeAlignment,
    this.activeColor,
    this.activeTextColor,
    this.activeTextStyle,
    this.activeTitle,
    this.inActiveBorderRadius,
    this.inActiveBorder,
    this.inActiveAlignment,
    this.inActiveColor,
    this.inActiveTextColor,
    this.inActiveTextStyle,
    this.inActiveTitle,
    this.activeWidget,
    this.inActiveWidget,
    this.isActive = true,
    this.isSecondary = false,
    this.activeGradient,
    this.inActiveGradient,
    required this.press,
    this.padding,
    this.haveGradient = false,
    this.isFullSize = true,
  });
  final _themeCurrent = getIt<ThemeCubit>();

  @override
  Widget build(BuildContext context) {
    return isFullSize
        ? _buttonWidget(context)
        : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buttonWidget(context)],
        );
  }

  SingleTapDetector _buttonWidget(BuildContext context) {
    return SingleTapDetector(
      onTap: () {
        if (isActive || isSecondary) {
          press.call();
        }
      },
      child: AnimatedContainer(
        duration: Const.DURATION_ANIMATION,
        curve: Const.EFFECT_ANIMATION,
        alignment:
            isActive
                ? (activeAlignment ?? Alignment.center)
                : (inActiveAlignment ?? Alignment.center),
        height: height,
        width: width,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          // gradient:
          //     haveGradient == true
          //         ? (isActive
          //             ? (activeGradient ?? AppColors.linearBackground)
          //             : (inActiveGradient ?? AppColors.linearButtonDeActive))
          //         : null,
          border: isActive ? activeBorder : inActiveBorder,
          borderRadius:
              isActive
                  ? (activeBorderRadius ??
                      BorderRadius.all(Radius.circular(radius ?? 4.r)))
                  : inActiveBorderRadius ??
                      BorderRadius.all(Radius.circular(radius ?? 4.r)),
          color:
              isActive
                  ? (activeColor ?? _themeCurrent.appColors.primaryColor)
                  : (inActiveColor ?? _themeCurrent.appColors.backgroundColor),
        ),
        child:
            activeWidget ??
            AnimatedDefaultTextStyle(
              duration: Const.DURATION_ANIMATION,
              curve: Const.EFFECT_ANIMATION,
              style:
                  isActive
                      ? (activeTextStyle ??
                          Theme.of(context).textTheme.text16w500.copyWith(
                            color:
                                isActive
                                    ? (activeTextColor ??
                                        _themeCurrent.appColors.textPrimary)
                                    : (inActiveTextColor ??
                                        _themeCurrent.appColors.textSecondary),
                          ))
                      : (inActiveTextStyle ??
                          Theme.of(context).textTheme.text16w500.copyWith(
                            color:
                                isActive
                                    ? (activeTextColor ??
                                        _themeCurrent.appColors.textPrimary)
                                    : (inActiveTextColor ??
                                        _themeCurrent.appColors.textSecondary),
                          )),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  isActive ? (activeTitle ?? '') : (inActiveTitle ?? ''),
                ),
              ),
            ),
      ),
    );
  }
}
