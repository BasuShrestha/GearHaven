import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/order_detail.dart';
import 'package:gearhaven/app/models/renting.dart';

class RentingService extends RemoteServices {
  RentingService() : super();

  Future<String> makeRentalPayment({
    required int productId,
    required int ownerId,
    required int renterId,
    required String fromDate,
    required String toDate,
    required String paymentStatus,
    required String rentingStatus,
    required String transactionType,
    required double amountPaid,
    required String otherData,
    required String productName,
    required String ownerFcmToken,
  }) async {
    try {
      debugPrint("Services total: $amountPaid");
      String endPoint = '/make-rental-payment';
      Response response = await json_dio.post(
        endPoint,
        data: json.encode({
          "productId": productId,
          "ownerId": ownerId,
          "renterId": renterId,
          "fromDate": fromDate,
          "toDate": toDate,
          "paymentStatus": paymentStatus,
          "rentingStatus": rentingStatus,
          "transactionType": transactionType,
          "amountPaid": amountPaid,
          "otherData": otherData,
          "productName": productName,
          "ownerFcmToken": ownerFcmToken
        }),
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

  Future<List<Renting>> fetchRentingsByOwnerId(int ownerId) async {
    try {
      String endpoint = '/renting/owner/$ownerId';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      List<Renting> rentings = (response.data as List)
          .map((rentingJson) => Renting.fromJson(rentingJson))
          .toList();
      return rentings;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "Server error occurred: ${e.response!.statusCode} ${e.response!.data}");
        if (e.response?.statusCode == 404) {
          return Future.error("Rentings not found for owner id: $ownerId");
        } else if (e.response?.statusCode == 401) {
          return Future.error("Unauthorized access. Please login again.");
        } else {
          return Future.error(
              "Error fetching rentings: ${e.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${e.message}");
        throw Exception(
            "Network error occurred while fetching rentings. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception(
          "Unexpected error occurred while fetching rentings. Please try again later.");
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

  Future<String> updateRentingStatus({
    required int rentingId,
    required int productId,
    required String productName,
    required String status,
    // required String buyerFcm,
  }) async {
    try {
      String endpoint = '/renting';
      Response response = await json_dio.put(endpoint, data: {
        "rentingId": rentingId,
        "productId": productId,
        "productName": productName,
        "status": status,
        // "buyerFcm": buyerFcm,
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
