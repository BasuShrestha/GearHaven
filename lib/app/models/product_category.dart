// To parse this JSON data, do
//
//     final productCategory = productCategoryFromJson(jsonString);

import 'dart:convert';

ProductCategory productCategoryFromJson(String str) =>
    ProductCategory.fromJson(json.decode(str));

String productCategoryToJson(ProductCategory data) =>
    json.encode(data.toJson());

class ProductCategory {
  final int? categoryId;
  final String? categoryName;

  ProductCategory({
    this.categoryId,
    this.categoryName,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
