import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/rental_product.dart';
import 'package:gearhaven/app/models/wishlist.dart';

class WishlistService extends RemoteServices {
  WishlistService() : super();

  Future<String> addToWishlist({
    required int userId,
    required int productId,
  }) async {
    try {
      String endPoint = '/add-to-wishlist';
      Response response = await json_dio.post(
        endPoint,
        data: json.encode({
          "userId": userId,
          "productId": productId,
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

  Future<List<Wishlist>> fetchWishlistByUserId(int userId) async {
    try {
      String endpoint = '/get-wishlist/$userId';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      List<Wishlist> wishlist = (response.data as List)
          .map((rentingJson) => Wishlist.fromJson(rentingJson))
          .toList();
      return wishlist;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "Server error occurred: ${e.response!.statusCode} ${e.response!.data}");
        if (e.response?.statusCode == 404) {
          return Future.error("Rentings not found for owner id: $userId");
        } else if (e.response?.statusCode == 401) {
          return Future.error("Unauthorized access. Please login again.");
        } else {
          return Future.error(
              "Error fetching wishlist: ${e.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${e.message}");
        throw Exception(
            "Network error occurred while fetching wishlist. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception(
          "Unexpected error occurred while fetching wishlist. Please try again later.");
    }
  }

  Future<String> updateRentingStatus({
    required int rentingId,
    required String status,
    // required String buyerFcm,
  }) async {
    try {
      String endpoint = '/renting';
      Response response = await json_dio.put(endpoint, data: {
        "rentingId": rentingId,
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

  Future<RentalProduct> fetchRentalProductById(int productId) async {
    try {
      String endpoint = '/products-rent/$productId';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      return RentalProduct.fromJson(response.data[0]);
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 409) {
        return Future.error('409 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 401) {
        return Future.error('401 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 400) {
        return Future.error('400 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 404) {
        return Future.error('404 Error: ${dioError.response?.data['message']}');
      } else if (dioError.response?.statusCode == 500) {
        return Future.error('500 Error: ${dioError.response?.data['message']}');
      } else {
        return Future.error("Error in the code");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception("Error: ${e.toString()}");
    }
  }

  Future<String> removeFromWishlist({
    required int wishlistId,
  }) async {
    try {
      String endpoint = '/remove-from-wishlist/$wishlistId';
      Response response = await json_dio.delete(endpoint);
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
