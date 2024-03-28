// To parse this JSON data, do
//
//     final rentalProduct = rentalProductFromJson(jsonString);

import 'dart:convert';

RentalProduct rentalProductFromJson(String str) =>
    RentalProduct.fromJson(json.decode(str));

String rentalProductToJson(RentalProduct data) => json.encode(data.toJson());

class RentalProduct {
  final int? productId;
  final String? productName;
  final double? productPrice;
  final int? productstockQuantity;
  final String? productDesc;
  final String? productImage;
  final int? productcategoryId;
  final int? productsizeId;
  final int? productconditionId;
  final int? productownerId;
  final int? forRent;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;
  final String? ownerFcm;
  final String? categoryName;
  final String? productconditionName;
  final String? productsizeName;
  final double? ratePerDay;

  RentalProduct({
    this.productId,
    this.productName,
    this.productPrice,
    this.productstockQuantity,
    this.productDesc,
    this.productImage,
    this.productcategoryId,
    this.productsizeId,
    this.productconditionId,
    this.productownerId,
    this.forRent,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.ownerFcm,
    this.categoryName,
    this.productconditionName,
    this.productsizeName,
    this.ratePerDay,
  });

  factory RentalProduct.fromJson(Map<String, dynamic> json) => RentalProduct(
        productId: json["product_id"],
        productName: json["product_name"],
        productPrice: double.tryParse(json["product_price"].toString()),
        productstockQuantity: json["productstock_quantity"],
        productDesc: json["product_desc"],
        productImage: json["product_image"],
        productcategoryId: json["productcategory_id"],
        productsizeId: json["productsize_id"],
        productconditionId: json["productcondition_id"],
        productownerId: json["productowner_id"],
        forRent: json["for_rent"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userName: json["user_name"],
        ownerFcm: json["owner_fcm"],
        categoryName: json["category_name"],
        productconditionName: json["productcondition_name"],
        productsizeName: json["productsize_name"],
        ratePerDay: double.tryParse(json["rate_per_day"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_price": productPrice,
        "productstock_quantity": productstockQuantity,
        "product_desc": productDesc,
        "product_image": productImage,
        "productcategory_id": productcategoryId,
        "productsize_id": productsizeId,
        "productcondition_id": productconditionId,
        "productowner_id": productownerId,
        "for_rent": forRent,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_name": userName,
        "owner_fcm": ownerFcm,
        "category_name": categoryName,
        "productcondition_name": productconditionName,
        "productsize_name": productsizeName,
        "rate_per_day": ratePerDay,
      };
}
