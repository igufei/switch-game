import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/app/pages/archive/views/archive_view.dart';
import 'package:switch_game/app/pages/game/views/game_view.dart';
import 'package:switch_game/app/pages/key/views/key_view.dart';
import 'package:switch_game/app/pages/mod/views/mod_view.dart';
import 'package:window_manager/window_manager.dart';

class HomeController extends GetxController {
  var pageIndex = 0.obs;
  var pages = <Widget>[GameView(), ArchiveView(), KeyView(), ModView()];
  @override
  void onReady() {
    windowManager.waitUntilReadyToShow(
        WindowOptions(
          title: "Switch游戏",
          size: Size(1030, 700),
          center: true,
          backgroundColor: Colors.transparent,
          skipTaskbar: false,
          titleBarStyle: TitleBarStyle.hidden,
        ), () async {
      await windowManager.setResizable(false);
      await windowManager.show();
      await windowManager.focus();
    });
    super.onReady();
  }
}
