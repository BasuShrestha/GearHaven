// To parse this JSON data, do
//
//     final productCondition = productConditionFromJson(jsonString);

import 'dart:convert';

ProductCondition productConditionFromJson(String str) =>
    ProductCondition.fromJson(json.decode(str));

String productConditionToJson(ProductCondition data) =>
    json.encode(data.toJson());

class ProductCondition {
  final int? productconditionId;
  final String? productconditionName;

  ProductCondition({
    this.productconditionId,
    this.productconditionName,
  });

  factory ProductCondition.fromJson(Map<String, dynamic> json) =>
      ProductCondition(
        productconditionId: json["productcondition_id"],
        productconditionName: json["productcondition_name"],
      );

  Map<String, dynamic> toJson() => {
        "productcondition_id": productconditionId,
        "productcondition_name": productconditionName,
      };
}
