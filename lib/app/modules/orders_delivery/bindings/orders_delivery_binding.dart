import 'package:get/get.dart';

import '../controllers/orders_delivery_controller.dart';

class OrdersDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersDeliveryController>(
      () => OrdersDeliveryController(),
    );
  }
}
