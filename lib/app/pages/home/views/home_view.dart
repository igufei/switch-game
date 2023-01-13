import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/widgets/desktop_scaffold.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DesktopScaffold(
      pages: controller.pages,
      selectedColor: Get.theme.primaryColorDark,
      trailing: Container(
        padding: EdgeInsets.only(bottom: 5),
        child: Obx(() => Text(
              '版本 v${controller.version.value}',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            )),
      ),
    );
  }
}
