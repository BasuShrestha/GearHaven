// To parse this JSON data, do
//
//     final productSize = productSizeFromJson(jsonString);

import 'dart:convert';

ProductSize productSizeFromJson(String str) =>
    ProductSize.fromJson(json.decode(str));

String productSizeToJson(ProductSize data) => json.encode(data.toJson());

class ProductSize {
  final int? productsizeId;
  final String? productsizeName;

  ProductSize({
    this.productsizeId,
    this.productsizeName,
  });

  factory ProductSize.fromJson(Map<String, dynamic> json) => ProductSize(
        productsizeId: json["productsize_id"],
        productsizeName: json["productsize_name"],
      );

  Map<String, dynamic> toJson() => {
        "productsize_id": productsizeId,
        "productsize_name": productsizeName,
      };
}
