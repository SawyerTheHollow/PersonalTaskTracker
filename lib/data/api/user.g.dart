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

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      access_token: json['access_token'] as String,
      refresh_token: json['refresh_token'] as String,
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
    };

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      code: (json['code'] as num?)?.toInt(),
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{'code': instance.code, 'detail': instance.detail};
