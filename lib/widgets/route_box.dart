import 'package:flutter/widgets.dart';

class RouteBox extends StatefulWidget {
  final RouteController controller;
  final Widget initWidget;
  const RouteBox({
    super.key,
    required this.controller,
    required this.initWidget,
  });

  @override
  State<RouteBox> createState() => _RouteBoxState();
}

class RouteController extends ChangeNotifier {
  final List<Widget> _views = [];
  List<Widget> get views => _views;

  void back() {
    if (_views.length > 1) {
      _views.removeLast();
      notifyListeners();
    }
  }

  void next(Widget widget) {
    _views.add(widget);
    notifyListeners();
  }
}

class _RouteBoxState extends State<RouteBox> {
  int viewIndex = 0;
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: viewIndex,
      children: widget.controller.views,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  @override
  void initState() {
    if (widget.controller.views.length == 0) {
      widget.controller.next(widget.initWidget);
    } else {
      if (mounted) {
        setState(() {
          viewIndex = widget.controller.views.length - 1;
        });
      }
    }

    widget.controller.addListener(listener);
    super.initState();
  }

  void listener() {
    if (mounted) {
      setState(() {
        viewIndex = widget.controller.views.length - 1;
      });
    }
  }
}
