
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.height,
    required this.width,
    this.color,
    this.colorText,
    required this.text,
    this.fontWeight,
    this.fontSize,
    this.onTap,
    this.borderRadius,
    this.border,
    this.textAlign,
    super.key,
  });
  final double height;
  final double width;
  final Color? color;
  final Color? colorText;
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final void Function()? onTap;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: border,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: textAlign,
            style: GoogleFonts.inter(
              color: colorText,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
