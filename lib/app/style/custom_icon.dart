
import 'package:flutter/cupertino.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.icon,
    this.color,
    this.size,
  });

  final IconData icon;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Icon(
        icon,
      color: color,
      size: size,
      weight: 500,
    );
  }
}
