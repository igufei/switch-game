import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:switch_game/app/pages/archive/views/archive_view.dart';
import 'package:switch_game/app/pages/game/views/game_view.dart';
import 'package:switch_game/app/pages/key/views/key_view.dart';
import 'package:switch_game/app/pages/mod/views/mod_view.dart';
import 'package:switch_game/app/pages/tools/views/tools_view.dart';
import 'package:switch_game/modules/my_icons.dart';
import 'package:switch_game/widgets/desktop_scaffold.dart';
import 'package:window_manager/window_manager.dart';

class HomeController extends GetxController {
  var pages = [
    PageData(title: '游戏', icon: MyIcons.game, page: () => GameView()),
    PageData(title: '存档', icon: MyIcons.archive, page: () => ArchiveView()),
    PageData(title: '金手指', icon: MyIcons.lock, page: () => KeyView()),
    PageData(title: 'Mod', icon: MyIcons.mod, page: () => ModView()),
    PageData(title: '工具', icon: MyIcons.tool, page: () => ToolsView()),
  ];
  var version = ''.obs;
  @override
  void onInit() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    super.onInit();
  }

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
