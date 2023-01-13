import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/widgets/desktop_page.dart';

import '../components/game_list.dart';
import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  @override
  final controller = Get.put(GameController());
  GameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DesktopPage(
      title: 'Switch游戏下载',
      body: GameList(),
      routeController: controller.rc,
    );
  }
}
