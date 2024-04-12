// To parse this JSON data, do
//
//     final renting = rentingFromJson(jsonString);

import 'dart:convert';

Renting rentingFromJson(String str) => Renting.fromJson(json.decode(str));

String rentingToJson(Renting data) => json.encode(data.toJson());

class Renting {
  final int? rentingId;
  final int? productId;
  final int? ownerId;
  final int? renterId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? paymentStatus;
  final String? rentingStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? amountPaid;
  final String? userName;
  final String? userContact;
  final String? userLocation;
  final String? fcmToken;
  final String? productName;
  final String? productImage;

  Renting({
    this.rentingId,
    this.productId,
    this.ownerId,
    this.renterId,
    this.fromDate,
    this.toDate,
    this.paymentStatus,
    this.rentingStatus,
    this.createdAt,
    this.updatedAt,
    this.amountPaid,
    this.userName,
    this.userContact,
    this.userLocation,
    this.fcmToken,
    this.productName,
    this.productImage,
  });

  factory Renting.fromJson(Map<String, dynamic> json) => Renting(
        rentingId: json["renting_id"],
        productId: json["product_id"],
        ownerId: json["owner_id"],
        renterId: json["renter_id"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        paymentStatus: json["payment_status"],
        rentingStatus: json["renting_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        amountPaid: int.tryParse(json["amount_paid"].toString()),
        userName: json["user_name"],
        userContact: json["user_contact"],
        userLocation: json["user_location"],
        fcmToken: json["fcm_token"],
        productName: json["product_name"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "renting_id": rentingId,
        "product_id": productId,
        "owner_id": ownerId,
        "renter_id": renterId,
        "from_date": fromDate?.toIso8601String(),
        "to_date": toDate?.toIso8601String(),
        "payment_status": paymentStatus,
        "renting_status": rentingStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "amount_paid": amountPaid,
        "user_name": userName,
        "user_contact": userContact,
        "user_location": userLocation,
        "fcm_token": fcmToken,
        "product_name": productName,
        "product_image": productImage,
      };
}
