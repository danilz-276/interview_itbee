// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_enum_common_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnumValue _$EnumValueFromJson(Map<String, dynamic> json) => EnumValue(
      value: json['value'] as String?,
      display: json['display'] as String?,
    );

Map<String, dynamic> _$EnumValueToJson(EnumValue instance) => <String, dynamic>{
      'value': instance.value,
      'display': instance.display,
    };

GetAllEnumsResponse _$GetAllEnumsResponseFromJson(Map<String, dynamic> json) =>
    GetAllEnumsResponse(
      enumName: json['enumName'] as String?,
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => EnumValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllEnumsResponseToJson(
        GetAllEnumsResponse instance) =>
    <String, dynamic>{
      'enumName': instance.enumName,
      'values': instance.values,
    };
