import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/widgets/click.dart';
import 'package:switch_game/widgets/desktop_page.dart';

import '../controllers/key_controller.dart';

class KeyView extends GetView<KeyController> {
  @override
  final controller = Get.put(KeyController());
  KeyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DesktopPage(
      title: 'Switch金手指下载',
      body: Center(
        child: Click(
          onClick: () {
            controller.rc.next(Text('second page'));
          },
          child: Text(
            locale: Locale('zh', 'CN'),
            '内容开发中...',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      routeController: controller.rc,
    );
  }
}
