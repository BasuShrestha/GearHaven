// To parse this JSON data, do
//
//     final registrationResponse = registrationResponseFromJson(jsonString);

import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) =>
    RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) =>
    json.encode(data.toJson());

class RegistrationResponse {
  final String? message;
  final String? fullHash;

  RegistrationResponse({
    this.message,
    this.fullHash,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        message: json["message"],
        fullHash: json["fullHash"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "fullHash": fullHash,
      };
}
