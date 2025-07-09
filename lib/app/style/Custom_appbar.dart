
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
    this.elevation,
    this.toolbarHeight,
    this.backgroundColor,
    super.key,
  });
 final Widget? leading;
 final Widget? title;
 final bool? centerTitle;
 final List<Widget>? actions;
 final double? elevation;
 final double? toolbarHeight;
 final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      leading: Padding(
        padding: EdgeInsets.only(
          top: height / 30,
          left: width / 30,
        ),
        child: leading,
      ),
      centerTitle: centerTitle,
      title: Padding(
        padding: EdgeInsets.only(
          top: height / 30,
        ),
        child: title,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 70);
}
