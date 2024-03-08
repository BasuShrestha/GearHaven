import 'package:get/get.dart';

import '../controllers/draft_controller.dart';

class DraftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DraftController>(
      () => DraftController(),
    );
  }
}
