import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/widgets/app_bar.dart';

import '../controllers/key_controller.dart';

class KeyView extends GetView<KeyController> {
  const KeyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowsAppBar(title: 'Switch金手指下载'),
      body: const Center(
        child: Text(
          '内容开发中...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
