import 'package:get/get.dart';

import '../controllers/mod_controller.dart';

class ModBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModController>(
      () => ModController(),
    );
  }
}
