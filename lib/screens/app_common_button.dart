import 'package:flutter/cupertino.dart';

class AppCommonButton extends StatelessWidget {
  const AppCommonButton(
      {super.key,
      required this.width,
      this.height,
      this.color,
      required this.child,
      required this.onPressed});

  final double width;
  final double? height;
  final Widget child;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoButton(
            onPressed: onPressed,
            color: color,
            borderRadius: BorderRadius.circular(15),
            child: child));
  }
}
