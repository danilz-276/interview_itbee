import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../model/responses/common/get_enum_common_res.dart';
import '../utils/app_enum.dart';
import 'csv_loader/csv_asset_loader.dart';
import 'strings.dart';

class Localization {
  String appLanguageCode = 'vi'; // Mặc định Tiếng Việt nếu chưa có dữ liệu

  static List<Locale> supportedLanguage = [
    LanguageType.ENGLISH.locale,
    LanguageType.VIETNAM.locale,
  ];

  List<EnumValue> listEnumLocalization() {
    return [
      EnumValue(
        value: LanguageType.VIETNAM.languageCode,
        display: Strings.hello,
        languageType: LanguageType.VIETNAM,
      ),
      EnumValue(
        value: LanguageType.ENGLISH.languageCode,
        display: Strings.hello,
        languageType: LanguageType.ENGLISH,
      ),
    ];
  }

  static const String languageFilePath = 'assets/languages/languages.csv';

  // Future<void> initLanguage() async {
  //   Language? currentLang = await _languageDao.getCurrentLanguage();
  //   if (currentLang != null) {
  //     appLanguageCode = currentLang.code;
  //   }
  // }

  static Widget getLocalizationWidget({required Widget app}) {
    return EasyLocalization(
      supportedLocales: supportedLanguage,
      path: languageFilePath,
      fallbackLocale: LanguageType.VIETNAM.locale,
      startLocale: LanguageTypeExt.getLanguageTypeFromCode('vi').locale,
      useOnlyLangCode: true,
      saveLocale: true,
      assetLoader: CsvAssetLoader(),
      child: app,
    );
  }

  // Future<void> changeLanguage(BuildContext context, Locale locale) async {
  //   Language? currentLang = await _languageDao.getCurrentLanguage();
  //   final LanguageType currentLanguage =
  //       LanguageTypeExt.getLanguageTypeFromCode(currentLang?.code ?? '');

  //   if (currentLanguage.locale == locale ||
  //       !supportedLanguage.contains(locale)) {
  //     return;
  //   }

  //   await _languageDao.updateLanguage(
  //     Language(code: locale.languageCode, name: locale.countryCode ?? ''),
  //   );

  //   if (context.mounted) {
  //     await context.setLocale(locale);
  //   }
  // }

  // Future<void> loadLanguage(BuildContext context) async {
  //   Language? currentLang = await _languageDao.getCurrentLanguage();
  //   if (context.mounted) {
  //     await context.setLocale(
  //       LanguageTypeExt.getLanguageTypeFromCode(currentLang?.code ?? '').locale,
  //     );
  //   }
  // }

  // Future<LanguageType> getCurrentLanguage() async {
  //   Language? currentLang = await _languageDao.getCurrentLanguage();
  //   if (currentLang != null) {
  //     appLanguageCode = currentLang.code;
  //   } else {
  //     appLanguageCode = LanguageType.ENGLISH.languageCode;
  //   }
  //   return currentLang != null
  //       ? LanguageTypeExt.getLanguageTypeFromCode(currentLang.code)
  //       : LanguageType.ENGLISH;
  // }
}
