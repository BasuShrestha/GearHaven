import 'package:get/get.dart';

import '../controllers/product_description_controller.dart';

class ProductDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDescriptionController>(
      () => ProductDescriptionController(),
    );
  }
}
