/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsLanguagesGen {
  const $AssetsLanguagesGen();

  /// File path: assets/languages/LexendExa-VariableFont_wght.ttf
  String get lexendExaVariableFontWght => 'assets/languages/LexendExa-VariableFont_wght.ttf';

  /// File path: assets/languages/languages.csv
  String get languages => 'assets/languages/languages.csv';

  /// List of all assets
  List<String> get values => [lexendExaVariableFontWght, languages];
}

class $AssetsPngsGen {
  const $AssetsPngsGen();

  /// File path: assets/pngs/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/pngs/empty.png');

  /// List of all assets
  List<AssetGenImage> get values => [empty];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/ic_arrow_down.svg
  String get icArrowDown => 'assets/svgs/ic_arrow_down.svg';

  /// File path: assets/svgs/ic_arrow_left.svg
  String get icArrowLeft => 'assets/svgs/ic_arrow_left.svg';

  /// File path: assets/svgs/ic_arrow_right.svg
  String get icArrowRight => 'assets/svgs/ic_arrow_right.svg';

  /// File path: assets/svgs/ic_background.svg
  String get icBackground => 'assets/svgs/ic_background.svg';

  /// File path: assets/svgs/ic_bell.svg
  String get icBell => 'assets/svgs/ic_bell.svg';

  /// File path: assets/svgs/ic_calendar.svg
  String get icCalendar => 'assets/svgs/ic_calendar.svg';

  /// File path: assets/svgs/image_welcome.svg
  String get imageWelcome => 'assets/svgs/image_welcome.svg';

  /// List of all assets
  List<String> get values => [icArrowDown, icArrowLeft, icArrowRight, icBackground, icBell, icCalendar, imageWelcome];
}

class MyAssets {
  const MyAssets._();

  static const $AssetsLanguagesGen languages = $AssetsLanguagesGen();
  static const $AssetsPngsGen pngs = $AssetsPngsGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
