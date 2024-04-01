import 'package:gearhaven/app/data/services/product_services.dart';
import 'package:gearhaven/app/models/product.dart';
import 'package:gearhaven/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  ProductServices productServices = ProductServices();
  // Observable list of Product objects
  RxList<Product> products = RxList<Product>();
  var quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
    Get.put(CartController());
    //Get.put(ProfilePageController());
  }

  void getProducts() async {
    isLoading = true.obs;
    try {
      await productServices.fetchAllSalesProducts().then((value) {
        products.value = value;
        Get.snackbar(
          'Success',
          'Sales Products Fetched',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        isLoading = false.obs;
        update();
      }).onError((error, stackTrace) {
        Get.snackbar(
          'Error',
          error.toString(),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        isLoading = false.obs;
        update();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 50),
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
