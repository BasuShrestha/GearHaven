// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  final int? orderdetailsId;
  final int? orderId;
  final int? productId;
  final int? sellerId;
  final int? quantity;
  final double? lineTotal;
  final String? deliveryStatus;
  final int? userId;
  final DateTime? orderDate;
  final double? orderTotal;
  final String? userName;
  final String? userContact;
  final String? userLocation;
  final String? productName;
  final String? productImage;

  OrderDetail({
    this.orderdetailsId,
    this.orderId,
    this.productId,
    this.sellerId,
    this.quantity,
    this.lineTotal,
    this.deliveryStatus,
    this.userId,
    this.orderDate,
    this.orderTotal,
    this.userName,
    this.userContact,
    this.userLocation,
    this.productName,
    this.productImage,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderdetailsId: json["orderdetails_id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        sellerId: json["seller_id"],
        quantity: json["quantity"],
        lineTotal: json["line_total"]?.toDouble(),
        deliveryStatus: json["delivery_status"],
        userId: json["user_id"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        orderTotal: json["order_total"]?.toDouble(),
        userName: json["user_name"],
        userContact: json["user_contact"],
        userLocation: json["user_location"],
        productName: json["product_name"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "orderdetails_id": orderdetailsId,
        "order_id": orderId,
        "product_id": productId,
        "seller_id": sellerId,
        "quantity": quantity,
        "line_total": lineTotal,
        "delivery_status": deliveryStatus,
        "user_id": userId,
        "order_date": orderDate?.toIso8601String(),
        "order_total": orderTotal,
        "user_name": userName,
        "user_contact": userContact,
        "user_location": userLocation,
        "product_name": productName,
        "product_image": productImage,
      };

  OrderDetail copyWith({
    int? orderdetailsId,
    int? orderId,
    int? productId,
    int? sellerId,
    int? quantity,
    double? lineTotal,
    String? deliveryStatus,
    int? userId,
    DateTime? orderDate,
    double? orderTotal,
    String? userName,
    String? userContact,
    String? userLocation,
    String? productName,
    String? productImage,
  }) {
    return OrderDetail(
      orderdetailsId: orderdetailsId ?? this.orderdetailsId,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      quantity: quantity ?? this.quantity,
      lineTotal: lineTotal ?? this.lineTotal,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      userId: userId ?? this.userId,
      orderDate: orderDate ?? this.orderDate,
      orderTotal: orderTotal ?? this.orderTotal,
      userName: userName ?? this.userName,
      userContact: userContact ?? this.userContact,
      userLocation: userLocation ?? this.userLocation,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
    );
  }
}
