import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:switch_game/app/models/game_model.dart';
import 'package:switch_game/modules/tools.dart';
import 'package:switch_game/widgets/msg.dart';
import 'package:window_manager/window_manager.dart';

import 'app/routes/app_pages.dart';

void main() async {
  GameModel.initData();
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      //
      onInit: () async {
        Get.changeTheme(ThemeData(
          primaryColor: Color(0xffff312e),
          backgroundColor: Color.fromARGB(255, 248, 183, 182),
          primaryColorLight: Color(0xff00b6dd),
        ));
        var message = await Tools.check();
        if (message != '') {
          Msg.confirm('提示', message, onOK: () {
            windowManager.close();
          }, onCancel: null, barrierDismissible: false);
        }
      },
    ),
  );
}
