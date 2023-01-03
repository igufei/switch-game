import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/widgets/app_bar.dart';
import 'package:switch_game/widgets/click.dart';

import '../components/game_list.dart';
import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  @override
  final controller = Get.put(GameController());
  GameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowsAppBar(
        title: 'Switch游戏下载',
        leading: Obx(() {
          if (controller.viewIndex.value == 0) {
            return Container();
          }
          return Click(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            onClick: () {
              controller.viewIndex.value = 0;
            },
          );
        }),
      ),
      body: Obx(() => IndexedStack(
            index: controller.viewIndex.value,
            children: [
              GameList(),
              controller.gameDetail.value,
            ],
          )),
    );
  }
}
