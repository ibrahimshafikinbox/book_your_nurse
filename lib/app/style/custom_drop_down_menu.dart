import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/colors.dart';

class CustomDropDownFormField<T> extends StatelessWidget {
  const CustomDropDownFormField({
    super.key,
    required this.items,
    required this.hintText,
    this.hintStyle,
    this.onChanged,
    this.onSaved,
    this.validate,
    this.prefixIcon,
    this.suffixIcon,
    required this.value,
  });

  final List<DropdownMenuItem<T>> items;
  final String hintText;
  final TextStyle? hintStyle;
  final T? value;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validate,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxWidth: width / 1),
        filled: true,
        fillColor: AppColor.kGrey2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ?? GoogleFonts.inter(
          color: AppColor.kText3,
          fontSize: width / 21.4,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: height / 42,
          horizontal: height / 42,
        ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(AppColor.kPrimaryColor1),
        errorBorder: buildBorder(Colors.red),
      ),
      iconEnabledColor: AppColor.kPrimaryColor1,
      dropdownColor: AppColor.kGrey2,
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: color ?? AppColor.kText3,
      ),
    );
  }
}
