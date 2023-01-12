import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_game/modules/my_icons.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(minWidth: 600),
        child: Row(
          children: <Widget>[
            Obx(() => NavigationRail(
                  //backgroundColor: Color(0xff00b6dd), //背影色
                  //extended: true, //扩展显示，在图标的右边显示出文字
                  elevation: 5, //阴影
                  //groupAlignment: 0,图标组上下显示的位置，范围是-1.0至1.0
                  //labelType: NavigationRailLabelType.all,文本显示的类型，
                  minExtendedWidth: 140,
                  selectedIconTheme: IconThemeData(color: Get.theme.primaryColorDark, size: 30),
                  unselectedIconTheme: IconThemeData(color: Colors.black, size: 30),
                  destinations: [
                    NavigationRailDestination(
                      padding: EdgeInsets.all(0),
                      icon: Icon(MyIcons.game),
                      label: Text('游戏'),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.all(0),
                      icon: Icon(MyIcons.archive),
                      label: Text('存档'),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.all(0),
                      icon: Icon(MyIcons.lock),
                      label: Text('金手指'),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.all(0),
                      icon: Icon(MyIcons.mod),
                      label: Text('Mod'),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.all(0),
                      icon: Icon(MyIcons.tool),
                      label: Text('工具'),
                    ),
                  ],
                  selectedIndex: controller.pageIndex.value,
                  onDestinationSelected: (value) {
                    controller.pageIndex.value = value;
                  },
                  trailing: Expanded(
                      child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.bottomCenter,
                    child: Obx(() => Text(
                          locale: Locale('zh', 'CN'),
                          "v${controller.version}",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        )),
                  )),
                )),
            VerticalDivider(thickness: 1, width: 1),
            Obx(() => Expanded(
                  child: controller.pages[controller.pageIndex.value],
                ))
          ],
        ),
      ),
    );
  }
}
