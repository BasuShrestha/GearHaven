import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/cart_item.dart';
import 'package:gearhaven/app/models/order_response.dart';

class OrderService extends RemoteServices {
  OrderService() : super();

  Future<OrderResponse> createOrder({
    required int userId,
    required List cartItems,
  }) async {
    // FormData formData = FormData.fromMap({
    //   "userId": userId.toString(),
    //   "cart": cartItemsData,
    // });

    try {
      String endPoint = '/create-order';
      // debugPrint("FormData: ${formData.fields}");

      Response response = await json_dio
          .post(endPoint, data: {"userId": userId, "cart": cartItems});
      if (response.statusCode == 201) {
        return OrderResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Error: Server responded with status code ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      throw Exception("DioException: ${dioError.message}");
    } catch (e) {
      throw Exception("Exception: $e");
    }
  }

  Future<String> cancelOrder(int orderId) async {
    try {
      String endPoint = '/order/cancel/$orderId';
      Response response = await json_dio.put(endPoint);
      if (response.statusCode == 200) {
        var responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('message') &&
            responseData['message'] is String) {
          return responseData['message'];
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        return "Error: Server responded with status code ${response.statusCode}";
      }
    } on DioException catch (dioError) {
      return "DioException: ${dioError.message}";
    } catch (e) {
      return "Exception: $e";
    }
  }

  Future<String> payForOrder(int orderId) async {
    try {
      String endPoint = '/order/pay/$orderId';
      Response response = await json_dio.put(endPoint);
      if (response.statusCode == 200) {
        var responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('message') &&
            responseData['message'] is String) {
          return responseData['message'];
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        return "Error: Server responded with status code ${response.statusCode}";
      }
    } on DioException catch (dioError) {
      return "DioException: ${dioError.message}";
    } catch (e) {
      return "Exception: $e";
    }
  }
}
