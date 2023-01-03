import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Click extends GetView {
  final Widget child;
  final Function() onClick;
  Function()? onHover;
  Function()? onExit;
  Function()? onTapDown;
  Click({
    super.key,
    required this.child,
    required this.onClick,
    this.onHover,
    this.onExit,
    this.onTapDown,
  });
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onExit: (event) {
        onExit?.call();
      },
      onHover: (event) {
        onHover?.call();
      },
      child: GestureDetector(
        onTap: onClick,
        onTapDown: (details) {
          onTapDown?.call();
        },
        child: child,
      ),
    );
  }
}
