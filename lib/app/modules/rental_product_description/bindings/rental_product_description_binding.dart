import 'package:get/get.dart';

import '../controllers/rental_product_description_controller.dart';

class RentalProductDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentalProductDescriptionController>(
      () => RentalProductDescriptionController(),
    );
  }
}
