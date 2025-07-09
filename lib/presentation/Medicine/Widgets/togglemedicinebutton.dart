import 'package:flutter/material.dart';
import '../../../app/style/custom_text.dart';
class Togglemedicinebutton extends StatelessWidget {
  const Togglemedicinebutton({super.key, required this.title, required this.onTap, required this.colorcontainer, required this.colorText});
final String title;
final void Function() onTap;
final Color colorcontainer;
  final Color colorText;

  @override

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width / 2,
        alignment: Alignment.center,
        decoration:  BoxDecoration(

            border: Border(
              bottom: BorderSide(color: colorcontainer, width: 2),
            ),
        ),
        child: CustomText(
          text: title,
          fontWeight: FontWeight.w600,
          colorText: colorText,
          fontSize: width < 322
              ? 0.062111801242236 * width
              : width < 500
              ? width * 0.040
              : width < 800
              ? 0.03125 * width
              : width < 1200
              ? 0.0208333333333333 * width
              : 0.0192307692307692 *
              width,
        ),
      ),
    );
  }
}
