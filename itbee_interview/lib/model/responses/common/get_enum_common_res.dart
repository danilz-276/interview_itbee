// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:itbee_interview/utils/app_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_enum_common_res.g.dart';

@JsonSerializable()
class EnumValue {
  String? value;
  String? display;
  @JsonKey(includeFromJson: false, includeToJson: false)
  LanguageType? languageType;

  EnumValue({this.value, this.display, this.languageType});

  factory EnumValue.fromJson(Map<String, dynamic> json) =>
      _$EnumValueFromJson(json);

  Map<String, dynamic> toJson() => _$EnumValueToJson(this);
}

@JsonSerializable()
class GetAllEnumsResponse {
  String? enumName;
  List<EnumValue>? values;

  GetAllEnumsResponse({this.enumName, this.values});

  factory GetAllEnumsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllEnumsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllEnumsResponseToJson(this);
}
