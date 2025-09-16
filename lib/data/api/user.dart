import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? name;
  final String email;
  final String? password;

  User({required this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});
  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}

@JsonSerializable()
class ErrorResponse {
  final int? code;
  final String? detail;

  ErrorResponse({this.code, this.detail});
  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}
