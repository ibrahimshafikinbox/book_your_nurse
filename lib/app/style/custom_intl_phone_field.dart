
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../const/colors.dart';

class CustomInlPhoneField extends StatelessWidget {
  const CustomInlPhoneField({
    super.key,
    this.onChanged,
    required this.controller,
    this.onSaved,
    this.onSubmitted,
    this.validator,
    this.onCountryChanged,
  });
  final void Function(PhoneNumber)? onChanged;
  final void Function(Country)? onCountryChanged;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final void Function(PhoneNumber?)? onSaved;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return IntlPhoneField(

      focusNode: FocusNode(),
      onChanged: onChanged,
      onCountryChanged: onCountryChanged,
      onSaved: onSaved,
      onSubmitted: onSubmitted,
      validator: validator,
      keyboardType: TextInputType.phone,
      controller: controller,
      cursorColor: Colors.red,
      initialCountryCode: 'EG',
      languageCode: 'EG',
      style: GoogleFonts.inter(
        fontSize: width / 23,
        fontWeight: FontWeight.w400,
      ),
      dropdownTextStyle: GoogleFonts.inter(
        fontSize: width / 25,
        fontWeight: FontWeight.w400,
      ),
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        size: width / 16,
      ),
      decoration: InputDecoration(
        labelText: 'Enter Phone Number',
        filled: true,
        constraints: BoxConstraints(
          maxWidth: width / 1,
        ),
        fillColor: AppColor.kGrey2,
        focusColor: AppColor.kGrey2,
        hoverColor: AppColor.kGrey2,
        contentPadding: EdgeInsets.symmetric(
          vertical: height / 42,
          horizontal: height / 42,
        ),
        labelStyle: GoogleFonts.inter(
          color: AppColor.kText3,
          fontSize: width / 21.4,
          fontWeight: FontWeight.w400,
        ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(AppColor.kPrimaryColor1),
        errorBorder: buildBorder(Colors.red),
      ),

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
