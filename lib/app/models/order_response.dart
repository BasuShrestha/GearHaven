// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  final int? orderId;
  final String? message;

  OrderResponse({
    this.orderId,
    this.message,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        orderId: json["orderId"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "message": message,
      };
}
