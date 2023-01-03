import 'package:get/get.dart';

import '../controllers/key_controller.dart';

class KeyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeyController>(
      () => KeyController(),
    );
  }
}
