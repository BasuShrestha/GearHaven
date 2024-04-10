import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gearhaven/app/data/services/order_services.dart';
import 'package:gearhaven/app/models/order_detail.dart';
import 'package:gearhaven/app/utils/local_storage.dart';
import 'package:get/get.dart';

class OrdersPageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;

  RxList<OrderDetail> allOrders = RxList<OrderDetail>();
  // List<String> deliveryStatuses = [
  //   "Pending",
  //   "Dispatched",
  //   "In Transit",
  //   "Delivered"
  // ];
  RxList<OrderDetail> ordersNotDelivered = RxList<OrderDetail>();

  OrderService orderService = OrderService();
  @override
  void onInit() {
    super.onInit();
    getOrderedProductsForUser(LocalStorage.getUserId() ?? 0);
  }

  void updateOrderStatus(String orderId, String newStatus) {
    var orderIndex = allOrders.indexWhere((o) => o.orderId == orderId);
    if (orderIndex != -1) {
      // Cloning the order with updated status since it's a final property.
      var updatedOrder =
          allOrders[orderIndex].copyWith(deliveryStatus: newStatus);

      // Replace the old order with updated order
      allOrders[orderIndex] = updatedOrder;

      if (newStatus != "Delivered") {
        if (!ordersNotDelivered.any((o) => o.orderId == orderId)) {
          ordersNotDelivered.add(updatedOrder);
        }
      } else {
        ordersNotDelivered.removeWhere((o) => o.orderId == orderId);
      }
      update(); // This will trigger the UI to refresh
    } else {
      // Handle the case where the order is not found
      debugPrint('Order with ID $orderId not found');
    }
  }

  void getOrderedProductsForUser(int userId) async {
    isLoading.value = true;
    try {
      int currentUserId = LocalStorage.getUserId() ?? userId;
      debugPrint("Current User Id: ${currentUserId.toString()}");
      List<OrderDetail> fetchedProducts =
          await orderService.fetchOrderedProductsByBuyerId(currentUserId);

      if (fetchedProducts.isNotEmpty) {
        allOrders.assignAll(fetchedProducts);
        for (OrderDetail od in allOrders) {
          if (od.deliveryStatus != "Delivered") {
            ordersNotDelivered.add(od);
          }
        }
        debugPrint(fetchedProducts.length.toString());
        // Get.snackbar('All orders fetched successfully', '',
        //     backgroundColor: Colors.green, colorText: Colors.white);
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
