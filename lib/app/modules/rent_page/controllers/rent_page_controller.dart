import 'dart:convert';

import 'package:gearhaven/app/models/product.dart';
import 'package:gearhaven/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RentPageController extends GetxController {
  final count = 0.obs;

  final String userName = "Madison Eve";
  final String userEmail = "madisoneve@gmail.com";
  final String userContact = "987654321";
  final String userLocation = "Lakeside, Pokhara";

  var isLoading = false.obs;
  // Observable list of Product objects
  final RxList<Product> products = RxList<Product>();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    isLoading = true.obs;
    try {
      var url = '$baseUrl/products-rent';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint(
          result.toString(),
        );
        // Parse and store the products
        products.assignAll(
          result.map<Product>((product) => Product.fromJson(product)).toList(),
        );

        Get.snackbar(
          'Success',
          'All Products fetched successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isLoading = false.obs;
        update();
      } else if (response.statusCode == 404) {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        isLoading = false.obs;
        update();
      } else if (response.statusCode == 500) {
        Get.snackbar(
          'Error',
          result['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading = false.obs;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading = false.obs;
      update();
      debugPrint(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
