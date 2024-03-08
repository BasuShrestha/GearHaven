import 'package:get/get.dart';

import '../controllers/sell_page_controller.dart';

class SellPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellPageController>(
      () => SellPageController(),
    );
  }
}
