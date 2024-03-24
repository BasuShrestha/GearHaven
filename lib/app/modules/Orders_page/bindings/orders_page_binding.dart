import 'package:get/get.dart';

import '../controllers/orders_page_controller.dart';

class OrdersPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersPageController>(
      () => OrdersPageController(),
    );
  }
}
