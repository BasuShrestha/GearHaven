// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

String wishlistToJson(Wishlist data) => json.encode(data.toJson());

class Wishlist {
  final int? wishlistId;
  final int? userId;
  final int? productId;
  final int? notificationSent;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? productName;
  final String? productImage;
  final int? productcategoryId;
  final int? productsizeId;
  final int? productconditionId;
  final int? productownerId;
  final String? categoryName;
  final String? productconditionName;
  final String? productsizeName;
  final DateTime? toDate;
  final int? renterId;
  final String? rentingStatus;

  Wishlist({
    this.wishlistId,
    this.userId,
    this.productId,
    this.notificationSent,
    this.createdAt,
    this.updatedAt,
    this.productName,
    this.productImage,
    this.productcategoryId,
    this.productsizeId,
    this.productconditionId,
    this.productownerId,
    this.categoryName,
    this.productconditionName,
    this.productsizeName,
    this.toDate,
    this.renterId,
    this.rentingStatus,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        wishlistId: json["wishlist_id"],
        userId: json["user_id"],
        productId: json["product_id"],
        notificationSent: json["notification_sent"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productName: json["product_name"],
        productImage: json["product_image"],
        productcategoryId: json["productcategory_id"],
        productsizeId: json["productsize_id"],
        productconditionId: json["productcondition_id"],
        productownerId: json["productowner_id"],
        categoryName: json["category_name"],
        productconditionName: json["productcondition_name"],
        productsizeName: json["productsize_name"],
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        renterId: json["renter_id"],
        rentingStatus: json["renting_status"],
      );

  Map<String, dynamic> toJson() => {
        "wishlist_id": wishlistId,
        "user_id": userId,
        "product_id": productId,
        "notification_sent": notificationSent,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_name": productName,
        "product_image": productImage,
        "productcategory_id": productcategoryId,
        "productsize_id": productsizeId,
        "productcondition_id": productconditionId,
        "productowner_id": productownerId,
        "category_name": categoryName,
        "productcondition_name": productconditionName,
        "productsize_name": productsizeName,
        "to_date": toDate?.toIso8601String(),
        "renter_id": renterId,
        "renting_status": rentingStatus,
      };
}
