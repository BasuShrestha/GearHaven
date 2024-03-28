import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/order_services.dart';
import 'package:gearhaven/app/models/order_detail.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:get/get.dart';

class OrdersDeliveryController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;

  RxList<OrderDetail> orders = RxList<OrderDetail>();
  List<String> deliveryStatuses = [
    "Pending",
    "Dispatched",
    "In Transit",
    "Delivered"
  ];

  OrderService orderService = OrderService();

  @override
  void onInit() {
    super.onInit();
    getSoldProductsForUser();
  }

  void updateDeliveryStatus(
      int orderId, int productId, String newStatus, String buyerFcm) async {
    debugPrint("Product Id in update order: $productId");
    debugPrint("New status in update order: $newStatus");
    debugPrint("User Id in update order: ${LocalStorage.getUserId()}");
    try {
      await orderService
          .updateDeliveryStatus(
        sellerId: LocalStorage.getUserId() ?? 0,
        orderId: orderId,
        productId: productId,
        status: newStatus,
        buyerFcm: buyerFcm,
      )
          .then((value) {
        Get.snackbar(
          'Success',
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        getSoldProductsForUser();
        update();
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 500),
        );
      });
    } catch (e) {
      Get.snackbar(
        "Exception in code",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 500),
      );
    }
  }

  void getSoldProductsForUser() async {
    isLoading.value = true;
    try {
      int currentUserId = LocalStorage.getUserId() ?? 0;
      debugPrint("Current User Id: ${currentUserId.toString()}");
      List<OrderDetail> fetchedProducts =
          await orderService.fetchSoldProductsBySellerId(currentUserId);

      if (fetchedProducts.isNotEmpty) {
        orders.assignAll(fetchedProducts);
        debugPrint(fetchedProducts.length.toString());
        Get.snackbar(
          'All orders fetched successfully',
          '',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        update();
      } else {
        Get.snackbar(
          'Info',
          'No orders found',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
        update();
      }
    } catch (e) {
      // Get.snackbar(
      //   'Error',
      //   e.toString(),
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
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
