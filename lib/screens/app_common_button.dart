import 'package:flutter/cupertino.dart';

class AppCommonButton extends StatelessWidget {
  const AppCommonButton(
      {super.key,
      required this.width,
      this.height,
      this.color,
      required this.child,
      this.borderRadius = 15,
      required this.onPressed});

  final double width;
  final double? height;
  final Widget child;
  final Color? color;
  final Function()? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoButton(
            onPressed: onPressed,
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            child: child));
  }
}
