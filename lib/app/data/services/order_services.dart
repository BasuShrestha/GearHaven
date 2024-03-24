import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/order_detail.dart';
import 'package:gearhaven/app/models/order_response.dart';

class OrderService extends RemoteServices {
  OrderService() : super();

  Future<OrderResponse> createOrder({
    required int userId,
    required double orderTotal,
    required List cartItems,
  }) async {
    try {
      String endPoint = '/create-order';

      Response response = await json_dio.post(
        endPoint,
        data: {
          "userId": userId,
          "orderTotal": orderTotal,
          "cart": cartItems,
        },
      );
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

  Future<String> makePayment({
    required int userId,
    required int orderId,
    required double amountPaid,
    required String otherData,
  }) async {
    try {
      String endPoint = '/make-payment';
      Response response = await json_dio.post(
        endPoint,
        data: {
          "userId": userId,
          "orderId": orderId,
          "amountPaid": amountPaid,
          "otherData": otherData,
        },
      );
      if (response.statusCode == 201) {
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
      if (dioError.response?.statusCode == 409) {
        return Future.error('409 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 401) {
        return Future.error('401 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 400) {
        return Future.error('400 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 500) {
        return Future.error('500 Error: ${dioError.response?.data['message']}');
      } else {
        return Future.error("Error in the code");
      }
    } catch (e) {
      return "Exception: $e";
    }
  }

  Future<List<OrderDetail>> fetchSoldProductsBySellerId(int sellerId) async {
    try {
      String endpoint = '/order-details/seller/$sellerId';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      List<OrderDetail> products = (response.data as List)
          .map((orderDetailJson) => OrderDetail.fromJson(orderDetailJson))
          .toList();
      return products;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "Server error occurred: ${e.response!.statusCode} ${e.response!.data}");
        if (e.response?.statusCode == 404) {
          return Future.error(
              "Orders Details not found for Seller ID: $sellerId");
        } else if (e.response?.statusCode == 401) {
          return Future.error("Unauthorized access. Please login again.");
        } else {
          return Future.error(
              "Error fetching products: ${e.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${e.message}");
        throw Exception(
            "Network error occurred while fetching products. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception(
          "Unexpected error occurred while fetching products. Please try again later.");
    }
  }

  Future<List<OrderDetail>> fetchOrderedProductsByBuyerId(int buyerId) async {
    try {
      String endpoint = '/order-details/buyer/$buyerId';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      List<OrderDetail> products = (response.data as List)
          .map((orderDetailJson) => OrderDetail.fromJson(orderDetailJson))
          .toList();
      return products;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "Server error occurred: ${e.response!.statusCode} ${e.response!.data}");
        if (e.response?.statusCode == 404) {
          return Future.error(
              "Orders Details not found for Seller ID: $buyerId");
        } else if (e.response?.statusCode == 401) {
          return Future.error("Unauthorized access. Please login again.");
        } else {
          return Future.error(
              "Error fetching products: ${e.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${e.message}");
        throw Exception(
            "Network error occurred while fetching products. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception(
          "Unexpected error occurred while fetching products. Please try again later.");
    }
  }

  Future<String> updateDeliveryStatus({
    required int sellerId,
    required int orderId,
    required int productId,
    required String status,
  }) async {
    try {
      String endpoint = '/order-details';
      Response response = await json_dio.put(endpoint, data: {
        "sellerId": sellerId,
        "orderId": orderId,
        "productId": productId,
        "status": status,
      });
      if (response.statusCode == 201) {
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
      if (dioError.response?.statusCode == 500) {
        return Future.error(dioError.response?.data['message']);
      } else if (dioError.response?.statusCode == 404) {
        return Future.error(dioError.response?.data['message']);
      } else {
        return Future.error("Dio Exception: ${dioError.toString()}");
      }
    } catch (e) {
      return "Exception: $e";
    }
  }
}
