import 'package:get/get.dart';

import '../controllers/active_rentings_controller.dart';

class ActiveRentingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveRentingsController>(
      () => ActiveRentingsController(),
    );
  }
}
