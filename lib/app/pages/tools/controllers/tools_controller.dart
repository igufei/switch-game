import 'package:get/get.dart';

class ToolsController extends GetxController {
  var toolList = [
    {
      'name': 'Yuzu模拟器',
      'icon': 'lib/assets/images/yuzu.png',
      'down_url': 'https://www.aliyundrive.com/s/twgoToKubu2&&&&9y5k',
      'summary': '''Yuzu是一款开源的Nintendo Switch模拟器，它使用c++开发，相比Ryujinx它运行的速度更快，更稳定。''',
    },
    {
      'name': 'Ryujinx模拟器',
      'icon': 'lib/assets/images/ryujinx.png',
      'down_url': 'https://www.aliyundrive.com/s/hYWvSz4gHTE&&&&x90u',
      'summary': '''Ryujinx是一款开源Nintendo Switch模拟器，它主要使用C #编写。相比Yuzu它支持的游戏更多。''',
    },
    {
      'name': 'Antdownload',
      'icon': 'lib/assets/images/baidu.png',
      'down_url': 'https://www.aliyundrive.com/s/4o1Qjzcfp7h&&&&gb18',
      'summary': '''Antdownload是一款百度网盘资源下载利器，支持不限速下载网盘资源，并且完全免费，能够直接实现满速下载，并且也不需要用户进行登录，直接复制粘贴链接就可以通过它快速下载。''',
    },
  ];
}
