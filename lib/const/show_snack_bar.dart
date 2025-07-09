
import 'package:flutter/material.dart';
import 'package:medical_app/const/colors.dart';

import '../app/style/custom_text.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText(
        text: message,
        colorText: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: AppColor.kPrimaryColor1,
    ),
  );
}