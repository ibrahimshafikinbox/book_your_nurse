
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRowButton extends StatelessWidget {
  const CustomRowButton({
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
    this.pathImage,
    this.heightImage,
    this.widthImage,
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
  final String? pathImage;
  final double? heightImage;
  final double? widthImage;
  @override
  Widget build(BuildContext context) {
    double kWidth = MediaQuery.of(context).size.width;
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
        child: Padding(
          padding: EdgeInsets.symmetric(
             //vertical: kWidth / 40,
             horizontal: kWidth / 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                  pathImage!,
                height: heightImage,
                width: widthImage,
              ),
              SizedBox(
                width: kWidth / 8,
              ),
              Text(
                text,
                textAlign: textAlign,
                style: GoogleFonts.inter(
                  color: colorText,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
