import 'package:get/get.dart';

import '../controllers/buy_page_controller.dart';

class BuyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyPageController>(
      () => BuyPageController(),
    );
  }
}
