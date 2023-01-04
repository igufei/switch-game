import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/widgets/app_bar.dart';

import '../controllers/mod_controller.dart';

class ModView extends GetView<ModController> {
  const ModView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowsAppBar(title: 'Switch Mod下载'),
      body: const Center(
        child: Text(
          '内容开发中...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
