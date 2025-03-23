import 'package:flutter/material.dart';

import 'gen_dark/colors.gen.dart';
import 'gen_light/colors.gen.dart';

class AppColors {
  static final light = AppColors._light();
  static final dark = AppColors._dark();

  final Color backgroundColor;
  final Color cardBackground;
  final Color iconColor;
  final Color primaryColor;
  final Color progressBlue;
  final Color progressGray;
  final Color progressOrange;
  final Color progressPink;
  final Color progressPurple;
  final Color taskCardBorder;
  final Color textPrimary;
  final Color textSecondary;

  AppColors._({
    required this.backgroundColor,
    required this.cardBackground,
    required this.iconColor,
    required this.primaryColor,
    required this.progressBlue,
    required this.progressGray,
    required this.progressOrange,
    required this.progressPink,
    required this.progressPurple,
    required this.taskCardBorder,
    required this.textPrimary,
    required this.textSecondary,
  });

  factory AppColors._light() {
    return AppColors._(
      backgroundColor: MyColorLight.backgroundColor,
      cardBackground: MyColorLight.cardBackground,
      iconColor: MyColorLight.iconColor,
      primaryColor: MyColorLight.primaryColor,
      progressBlue: MyColorLight.progressBlue,
      progressGray: MyColorLight.progressGray,
      progressOrange: MyColorLight.progressOrange,
      progressPink: MyColorLight.progressPink,
      progressPurple: MyColorLight.progressPurple,
      taskCardBorder: MyColorLight.taskCardBorder,
      textPrimary: MyColorLight.textPrimary,
      textSecondary: MyColorLight.textSecondary,
    );
  }

  factory AppColors._dark() {
    return AppColors._(
      backgroundColor: MyColorDark.backgroundColor,
      cardBackground: MyColorDark.cardBackground,
      iconColor: MyColorDark.iconColor,
      primaryColor: MyColorDark.primaryColor,
      progressBlue: MyColorDark.progressBlue,
      progressGray: MyColorDark.progressGray,
      progressOrange: MyColorDark.progressOrange,
      progressPink: MyColorDark.progressPink,
      progressPurple: MyColorDark.progressPurple,
      taskCardBorder: MyColorDark.taskCardBorder,
      textPrimary: MyColorDark.textPrimary,
      textSecondary: MyColorDark.textSecondary,
    );
  }
}
