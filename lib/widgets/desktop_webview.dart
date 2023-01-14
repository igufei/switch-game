import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:switch_game/widgets/msg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_windows/webview_windows.dart';

class DesktopWebview extends StatefulWidget {
  final String url;
  const DesktopWebview({super.key, required this.url});

  @override
  State<DesktopWebview> createState() => _DesktopWebviewState();
}

class _DesktopWebviewState extends State<DesktopWebview> {
  var initStatus = -1;
  final wc = WebviewController();
  @override
  Widget build(BuildContext context) {
    return compositeView();
  }

  Widget compositeView() {
    if (initStatus == 0) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('webview2浏览器内核没有被安装，是否安装？'),
          GFButton(
            onPressed: () async {
              var file = File('webview2.exe');
              var exists = await file.exists();
              if (exists) {
                await launchUrlString(file.path);
              } else {
                Msg.snackbar('webview2安装文件不存在，请自行搜索下载。');
              }
            },
            text: '立即安装',
            size: 30,
            shape: GFButtonShape.pills,
          )
        ],
      ));
    } else if (initStatus == 1) {
      return Webview(wc);
    }
    return Container();
  }

  @override
  void dispose() {
    wc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initWebview();
  }

  void initWebview() async {
    await wc.initialize();
    await wc.setPopupWindowPolicy(WebviewPopupWindowPolicy.sameWindow);

    if (!mounted) return;
    if (!wc.value.isInitialized) {
      initStatus = 0;
    } else {
      await wc.loadUrl(widget.url);
      initStatus = 1;
    }
    setState(() {});
  }
}
