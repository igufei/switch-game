import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      onInit: () {
        Get.changeTheme(ThemeData(
          primaryColor: Color(0xffff312e),
          backgroundColor: Color.fromARGB(255, 248, 183, 182),
          primaryColorLight: Color(0xff00b6dd),
        ));
      },
    ),
  );
}
