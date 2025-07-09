import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:medical_app/presentation/Booking/app_button.dart';
import 'package:medical_app/presentation/Booking/payment_view.dart';
import 'package:medical_app/presentation/resources/colors/colors.dart';
import 'package:medical_app/presentation/resources/styles/app_text_style.dart';

void showOrderReceivedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle, color: AppColors.green, size: 50),
            Text(
              'Order received',
              style: AppTextStyle.textStyleBoldBlack20,
            ),
            SizedBox(height: 10),
            Text(
              'Your order for the Booking the\nCarpinter has received, ',
              style: AppTextStyle.textStyleMediumAppBlack,
            ),
            SizedBox(height: 20),
            DefaultButton(
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentView()),
                  );
                },
                text: "Payment",
                textColor: AppColors.white),
          ],
        ),
      );
    },
  );
}
