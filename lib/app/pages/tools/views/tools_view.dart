// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/app/pages/home/components/tools_item.dart';
import 'package:switch_game/app/pages/tools/components/app_path.dart';
import 'package:switch_game/widgets/app_bar.dart';
import 'package:switch_game/widgets/click.dart';

import '../controllers/tools_controller.dart';

class ToolsView extends GetView {
  @override
  late ToolsController controller = Get.put(ToolsController());
  ToolsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowsAppBar(title: 'Switch模拟器'),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(20),
            child: Click(
                child: Icon(Icons.settings),
                onClick: () {
                  Get.dialog(
                    Dialog(child: AppPath()),
                    barrierDismissible: true,
                  );
                }),
          ),
          Container(
            alignment: Alignment.center,
            child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.toolList
                      .map((e) => Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: ToolsItem(
                              name: e['name'].toString(),
                              icon: e['icon'].toString(),
                              summary: e['summary'].toString(),
                              path: e['path'].toString(),
                            ),
                          ))
                      .toList(),
                )),
          ),
        ],
      ),
    );
  }
}
