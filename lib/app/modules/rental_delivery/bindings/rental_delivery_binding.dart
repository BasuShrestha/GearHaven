import 'package:get/get.dart';

import '../controllers/rental_delivery_controller.dart';

class RentalDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentalDeliveryController>(
      () => RentalDeliveryController(),
    );
  }
}
