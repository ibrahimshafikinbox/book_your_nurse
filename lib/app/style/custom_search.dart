import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/colors.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    super.key,
    required this.controller,
    this.maxLine = 1,
    this.onSaved,
    this.onChanged,
    this.validate,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final int maxLine;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final String? Function(String?)? validate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxWidth: width / 1.48,
          maxHeight: height / 10,
        ),
        filled: true,
        fillColor: AppColor.kGrey2,
        focusColor: AppColor.kGrey2,
        hoverColor: AppColor.kGrey2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return AppColor.kPrimaryColor1;
          }
          if (states.contains(MaterialState.error)) {
            return Colors.red;
          }
          return AppColor.kText3;
        }),
        suffixIconColor: AppColor.kText3,
        hintText: 'Search',
        contentPadding: EdgeInsets.symmetric(
          horizontal: height / 42,
          vertical: height / 55,
        ),
        hintStyle: GoogleFonts.inter(
          color: AppColor.kText3,
          fontSize: width / 23.4,
          fontWeight: FontWeight.w400,
        ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: const BorderSide(
        color: AppColor.kPrimaryColor1,
      ),
    );
  }
}
