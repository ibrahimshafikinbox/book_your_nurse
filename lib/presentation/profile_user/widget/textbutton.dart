
import 'package:flutter/material.dart';

import '../../../app/style/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
    this.colorText,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
  });
  final void Function()? onPressed;
  final String text;
  final Color? colorText;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: CustomText(
          text: text,
          colorText: colorText,
          fontWeight: fontWeight,
          fontSize: fontSize,
          textAlign: textAlign,
        ),
    );
  }
}