// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
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
  final String? userName;
  final String? categoryName;
  final String? productconditionName;
  final String? productsizeName;

  Product({
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
    this.userName,
    this.categoryName,
    this.productconditionName,
    this.productsizeName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        userName: json["user_name"],
        categoryName: json["category_name"],
        productconditionName: json["productcondition_name"],
        productsizeName: json["productsize_name"],
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
        "user_name": userName,
        "category_name": categoryName,
        "productcondition_name": productconditionName,
        "productsize_name": productsizeName,
      };
}
