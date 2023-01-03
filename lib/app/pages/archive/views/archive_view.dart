import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/widgets/app_bar.dart';

import '../controllers/archive_controller.dart';

class ArchiveView extends GetView<ArchiveController> {
  const ArchiveView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowsAppBar(title: 'Switch存档下载'),
      body: const Center(
        child: Text(
          'ArchiveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
