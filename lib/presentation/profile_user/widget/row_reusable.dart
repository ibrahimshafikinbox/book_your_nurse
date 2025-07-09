import 'package:flutter/material.dart';


import '../../../app/style/custom_icon.dart';
import '../../../const/colors.dart';
import 'package:flutter/material.dart';

class RowReusable extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final double leadingIconSize;
  final Widget title;
  final Widget? trailing;

  const RowReusable({
    Key? key,
    this.onTap,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.leadingIconSize,
    required this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // ADD THIS MINIMUM HEIGHT/PADDING:
        constraints: const BoxConstraints(minHeight: 56), // Material standard
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: leadingIconColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                leadingIcon,
                color: leadingIconColor,
                size: leadingIconSize,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(child: title),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}