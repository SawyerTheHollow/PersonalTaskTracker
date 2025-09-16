// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  name: json['name'] as String?,
  email: json['email'] as String,
  password: json['password'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
};

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      code: (json['code'] as num?)?.toInt(),
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{'code': instance.code, 'detail': instance.detail};
