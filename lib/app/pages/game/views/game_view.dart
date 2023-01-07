import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/widgets/app_bar.dart';
import 'package:switch_game/widgets/route_box.dart';

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
        routeController: controller.rc,
      ),
      body: RouteBox(
        controller: controller.rc,
        initWidget: GameList(),
      ),
    );
  }
}
