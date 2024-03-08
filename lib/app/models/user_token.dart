// To parse this JSON data, do
//
//     final userToken = userTokenFromJson(jsonString);

import 'dart:convert';

UserToken userTokenFromJson(String str) => UserToken.fromJson(json.decode(str));

String userTokenToJson(UserToken data) => json.encode(data.toJson());

class UserToken {
  final String? message;
  final String? accessToken;
  final String? refreshToken;

  UserToken({
    this.message,
    this.accessToken,
    this.refreshToken,
  });

  factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
        message: json["message"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
