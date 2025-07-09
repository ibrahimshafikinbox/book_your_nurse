import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    this.colorText,
    required this.text,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    super.key,
  });

  final Color? colorText;
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: colorText,
      ),
    );
  }
}
