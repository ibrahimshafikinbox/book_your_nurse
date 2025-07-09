
import 'package:flutter/material.dart';
import 'package:medical_app/app/style/custom_text.dart';
import 'package:medical_app/const/colors.dart';

import 'custom_button.dart';


class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({
    required this.text1,
    required this.text2,
    required this.textButton,
    required this.heightButton,
    required this.widthButton,
    required this.widget,
    this.onTap,
    super.key,
  });
  final String text1;
  final String text2;
  final String textButton;
  final double heightButton;
  final double widthButton;
  final Widget widget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: AppColor.kWhite,
      content: Padding(
        padding: EdgeInsets.only(
          top: height / 15,
          right: width / 40,
          left: width / 40,
        ),
        child: SizedBox(
          width: width / 1,
          height: height / 3.5,
          //color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColor.kColorCircle,
                radius: width / 8,
                child: Center(
                    child: widget,
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              CustomText(
                  text: text1,
                colorText: AppColor.kText1,
                fontSize: width / 18,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: width / 40,
              ),
              CustomText(
                text: text2,
                textAlign: TextAlign.center,
                colorText: AppColor.kText3,
                fontSize: width / 27,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              onTap: onTap,
                height: heightButton,
                width: widthButton,
                text: textButton,
              colorText: AppColor.kWhite,
              color: AppColor.kPrimaryColor1,
              borderRadius: BorderRadius.circular(32),
              fontWeight: FontWeight.w600,
              fontSize: width /23,
            ),
          ],
        ),
        SizedBox(
          height: height / 35,
        ),
      ],
    );
  }
}
