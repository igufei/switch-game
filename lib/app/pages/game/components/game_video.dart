import 'package:flutter/widgets.dart';
import 'package:webview_windows/webview_windows.dart';

class GameVideo extends StatefulWidget {
  final String videoUrl;
  const GameVideo({super.key, required this.videoUrl});

  @override
  State<GameVideo> createState() => _GameVideoState();
}

class _GameVideoState extends State<GameVideo> {
  final wc = WebviewController();
  @override
  Widget build(BuildContext context) {
    return compositeView();
  }

  Widget compositeView() {
    if (wc.value.isInitialized) {
      return Center(child: Text('webview2浏览器内核没有被安装，请安装后尝试！'));
    } else {
      return Webview(wc);
    }
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
    await wc.loadUrl(widget.videoUrl);
    if (!mounted) return;
    setState(() {});
  }
}
