import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gearhaven/app/data/services/remote_services.dart';
import 'package:gearhaven/app/models/rental_product.dart';
import 'package:gearhaven/app/models/product.dart';
import 'package:gearhaven/app/models/product_category.dart';
import 'package:gearhaven/app/models/product_condition.dart';
import 'package:gearhaven/app/models/product_size.dart';
import 'package:flutter/material.dart';

class ProductServices extends RemoteServices {
  ProductServices() : super();

  Future<String> uploadProduct({
    required String name,
    double? price,
    required int quantity,
    required String description,
    required String fileName,
    Uint8List? imageBytes,
    required int category,
    required int size,
    int? condition,
    required int ownerId,
    double? rateForDay,
    required bool forRent,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "price": price,
      "stockQuantity": quantity,
      "description": description,
      "image": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
      "categoryId": category,
      "sizeId": size,
      "conditionId": condition,
      "ownerId": ownerId,
      "ratePerDay": rateForDay,
    });

    try {
      String endpoint = forRent ? '/products/rent' : '/products/sale';
      Response response = await multipart_dio.post(endpoint, data: formData);
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
      return "DioException: ${dioError.message}";
    } catch (e) {
      return "Exception: $e";
    }
  }

  Future<String> updateSalesProduct({
    required int productId,
    required String name,
    required double price,
    required int quantity,
    required String description,
    required String fileName,
    Uint8List? imageBytes,
    required int category,
    required int size,
    required int condition,
    required int ownerId,
    //required bool forRent,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "price": price,
      "stockQuantity": quantity,
      "description": description,
      "image": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
      "categoryId": category,
      "sizeId": size,
      "conditionId": condition,
      "ownerId": ownerId,
    });

    try {
      String endpoint = '/products/sales/$productId';
      Response response = await multipart_dio.put(endpoint, data: formData);
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

  Future<String> updateRentalProduct({
    required int productId,
    required String name,
    double? price,
    required int quantity,
    required String description,
    required String fileName,
    Uint8List? imageBytes,
    required int category,
    required int size,
    int? condition,
    required int ownerId,
    required double? ratePerDay,
    //required bool forRent,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "price": price,
      "stockQuantity": quantity,
      "description": description,
      "image": imageBytes != null
          ? MultipartFile.fromBytes(imageBytes, filename: fileName)
          : null,
      "categoryId": category,
      "sizeId": size,
      "conditionId": condition,
      "ownerId": ownerId,
      "ratePerDay": ratePerDay,
    });

    try {
      String endpoint = '/products/rent/$productId';
      Response response = await multipart_dio.put(endpoint, data: formData);
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

  Future<String> deleteProduct({
    required int productId,
  }) async {
    try {
      String endpoint = '/products/$productId';
      Response response = await json_dio.delete(endpoint);
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

  Future<List<ProductSize>> getAllProductSizes() async {
    try {
      final response = await json_dio.get('/product-size');
      debugPrint(response.data.toString());
      return response.data
          .map<ProductSize>((productSize) => ProductSize.fromJson(productSize))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error(err.response?.data['message']);
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<ProductCategory>> getAllProductCategories() async {
    try {
      final response = await json_dio.get('/product-category');
      debugPrint(response.data.toString());
      return response.data
          .map<ProductCategory>(
              (productCategory) => ProductCategory.fromJson(productCategory))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error(err.response?.data['message']);
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<ProductCondition>> getAllProductConditions() async {
    try {
      final response = await json_dio.get('/product-condition');
      debugPrint(response.data.toString());
      return response.data
          .map<ProductCondition>(
              (productCondition) => ProductCondition.fromJson(productCondition))
          .toList();
    } on DioException catch (err) {
      if (err.response?.statusCode == 500) {
        return Future.error(err.response?.data['message']);
      } else {
        return Future.error('Error in the code');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Product>> fetchAllSalesProducts() async {
    try {
      String endpoint = '/products-sale';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      List<Product> products = (response.data as List).map((productJson) {
        debugPrint(Product.fromJson(productJson).productPrice.toString());
        return Product.fromJson(productJson);
      }).toList();
      return products;
    } on DioException catch (err) {
      if (err.response != null) {
        debugPrint(
            "Server error occurred: ${err.response!.statusCode} ${err.response!.data}");
        if (err.response?.statusCode == 500) {
          return Future.error(err.response?.data['message']);
        } else {
          return Future.error(
              "Error fetching products: ${err.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${err.message}");
        throw Exception(
            "Network error occurred while fetching products. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception(
          "Unexpected error occurred while fetching products. Please try again later.");
    }
  }

  Future<List<Product>> fetchFilteredSaleProducts({
    int? categoryId,
    int? conditionId,
    int? sizeId,
    double? priceMin,
    double? priceMax,
  }) async {
    try {
      String endpoint = '/products-sale/filtered';
      Map<String, dynamic> filters = {};

      // Add filters to the request body if they are not null
      if (categoryId != null) filters['categoryId'] = categoryId;
      if (conditionId != null) filters['conditionId'] = conditionId;
      if (sizeId != null) filters['sizeId'] = sizeId;
      if (priceMin != null) filters['priceMin'] = priceMin;
      if (priceMax != null) filters['priceMax'] = priceMax;

      final response = await json_dio.post(endpoint, data: filters);
      debugPrint(response.data.toString());

      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        return products;
      } else {
        throw Exception(
            "Server responded with status code: ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      debugPrint("DioException occurred: ${dioError.message}");
      throw Exception("DioException: ${dioError.message}");
    } catch (e) {
      debugPrint("Unexpected error occurred: $e");
      throw Exception("Error fetching filtered products: $e");
    }
  }

  Future<List<RentalProduct>> fetchAllRentalProducts() async {
    try {
      String endpoint = '/products-rent';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      List<RentalProduct> products = (response.data as List).map((productJson) {
        debugPrint(RentalProduct.fromJson(productJson).productPrice.toString());
        return RentalProduct.fromJson(productJson);
      }).toList();
      return products;
    } on DioException catch (err) {
      if (err.response != null) {
        debugPrint(
            "Server error occurred: ${err.response!.statusCode} ${err.response!.data}");
        if (err.response?.statusCode == 500) {
          return Future.error(err.response?.data['message']);
        } else {
          return Future.error(
              "Error fetching products: ${err.response!.statusCode}");
        }
      } else {
        debugPrint("Network error: ${err.message}");
        throw Exception(
            "Network error occurred while fetching products. Please check your connection and try again.");
      }
    } catch (e) {
      debugPrint("Unexpected error fetching products: $e");
      throw Exception(
          "Unexpected error occurred while fetching products. Please try again later.");
    }
  }

  Future<List<Product>> fetchSalesProductsByOwnerId(int ownerId) async {
    try {
      String endpoint = '/products/sale/owner/$ownerId';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      List<Product> products = (response.data as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      return products;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            "Server error occurred: ${e.response!.statusCode} ${e.response!.data}");
        if (e.response?.statusCode == 404) {
          return Future.error("Products not found for owner ID: $ownerId");
        } else if (e.response?.statusCode == 401) {
          return Future.error("Unauthorized access. Please login again.");
        } else {
          return Future.error(
              "Error fetching products: ${e.response!.statusCode} ${e.response!.data}");
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

  Future<List<RentalProduct>> fetchRentalProductsByOwnerId(int ownerId) async {
    try {
      String endpoint = '/products/rent/owner/$ownerId';
      final response = await json_dio.get(endpoint);
      debugPrint(response.data.toString());

      List<RentalProduct> products = (response.data as List)
          .map((productJson) => RentalProduct.fromJson(productJson))
          .toList();
      return products;
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
}
