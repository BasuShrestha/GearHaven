// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

//User userFromJson(String str) => User.fromJson(json.decode(str));

User userFromJson(Map<String, dynamic> json) => User.fromJson(json);

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? userPassword;
  final String? userContact;
  final String? userLocation;
  final String? profileImage;
  final int? isVerified;
  final int? totalIncome;
  final dynamic token;
  final String? fcmToken;
  final String? refreshToken;
  final DateTime? refreshTokenExpiration;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userContact,
    this.userLocation,
    this.profileImage,
    this.isVerified,
    this.totalIncome,
    this.token,
    this.fcmToken,
    this.refreshToken,
    this.refreshTokenExpiration,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
        userContact: json["user_contact"],
        userLocation: json["user_location"],
        profileImage: json["profile_image"],
        isVerified: json["is_verified"],
        totalIncome: json["total_income"],
        token: json["token"],
        fcmToken: json["fcm_token"],
        refreshToken: json["refresh_token"],
        refreshTokenExpiration: json["refresh_token_expiration"] == null
            ? null
            : DateTime.parse(json["refresh_token_expiration"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_password": userPassword,
        "user_contact": userContact,
        "user_location": userLocation,
        "profile_image": profileImage,
        "is_verified": isVerified,
        "total_income": totalIncome,
        "token": token,
        "fcm_token": fcmToken,
        "refresh_token": refreshToken,
        "refresh_token_expiration": refreshTokenExpiration?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
