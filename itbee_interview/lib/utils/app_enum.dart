// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: constant_identifier_names
enum LanguageType { ENGLISH, VIETNAM }

extension LanguageTypeExt on LanguageType {
  String get languageCode {
    switch (this) {
      case LanguageType.ENGLISH:
        return 'en';
      case LanguageType.VIETNAM:
        return 'vi';
    }
  }

  Locale get locale {
    switch (this) {
      case LanguageType.ENGLISH:
        return const Locale('en', 'US');
      case LanguageType.VIETNAM:
        return const Locale('vi', 'VN');
    }
  }

  static LanguageType getLanguageTypeFromCode(String languageCode) {
    switch (languageCode) {
      case 'en':
        return LanguageType.ENGLISH;
      case 'vi':
        return LanguageType.VIETNAM;
      default:
        return LanguageType.VIETNAM;
    }
  }
}

enum ToastType { SUCCESS, ERROR }

extension ToastType_Ext on ToastType {
  Color get backgroundColor {
    switch (this) {
      case ToastType.SUCCESS:
        return Colors.greenAccent;
      case ToastType.ERROR:
        return Colors.redAccent;
    }
  }

  Color get titleColor {
    switch (this) {
      case ToastType.SUCCESS:
        return Colors.white;
      case ToastType.ERROR:
        return Colors.white;
    }
  }

  Color get subTitleColor {
    switch (this) {
      case ToastType.SUCCESS:
        return Colors.white;
      case ToastType.ERROR:
        return Colors.white;
    }
  }

  Color get crossColor {
    switch (this) {
      case ToastType.SUCCESS:
        return Colors.white;
      case ToastType.ERROR:
        return Colors.white;
    }
  }

  double get radius {
    switch (this) {
      case ToastType.SUCCESS:
        return 100.r;
      case ToastType.ERROR:
        return 100.r;
    }
  }
}

enum TaskStatus { TODO, DOING, DONE }

extension TaskStatus_Ext on TaskStatus {
  int get index {
    switch (this) {
      case TaskStatus.TODO:
        return 0;
      case TaskStatus.DONE:
        return 1;
      case TaskStatus.DOING:
        return 2;
    }
  }

  String get title {
    switch (this) {
      case TaskStatus.TODO:
        return 'TODO';
      case TaskStatus.DONE:
        return 'DONE';
      case TaskStatus.DOING:
        return 'DOING';
    }
  }
}
