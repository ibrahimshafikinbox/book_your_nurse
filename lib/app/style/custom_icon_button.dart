
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.onPressed,
    required this.icon,
    this.padding,
    this.color,
    super.key,
  });
final void Function()? onPressed;
final Widget icon;
  final Color? color;
final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
        onPressed: onPressed,
        icon: icon,
      color: color,
    );
  }
}
