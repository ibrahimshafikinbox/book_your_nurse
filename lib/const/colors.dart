import 'package:flutter/material.dart';
class AppColor{
  static const Color kPrimaryColor = Color(0xff147B72);
  static const Color kPrimaryColor1 = Color(0xff199A8E);
  static const Color kWhite = Color(0xffFFFFFF);
  static const Color kBlack = Color(0xff000000);
  static const Color kBlack1 = Color(0xff111B21);
  static const Color kText1 = Color(0xff101623);
  static const Color kText2 = Color(0xff717784);
  static const Color kText3 = Color(0xffA1A8B0);
  static const Color kText4 = Color(0xff555555);
  static const Color kGrey1 = Color(0xffF7F9FF);
  static const Color kGrey2 = Color(0xffF9FAFB);
  static const Color kGrey3 = Color(0xffE8F3F1);
  static const Color kColorCircle = Color(0xffF5F8FF);
  static const Color kIndicator = Color(0xffB8DFDD);
  static const Color kGreen1 = Color(0xffD9FDD3);
  static const Color kGreen2 = Color(0xff44C2B7);
  static const Color colorcircle2=Color(0xffE8F3F1);
  static const Color ratingColor=Color(0xffADADAD);
  static const Color dateColor=Color(0xff555555);
  static const Color doctorcolor=Color(0xffE8F3F1);
  static const Color namecolor=Color(0xff39414B);

  static const Color circlecolor=Color(0xff929292);



}
ThemeMode themeMode = ThemeMode.system;
changeMode(bool dark)
{
  dark? themeMode = ThemeMode.dark : ThemeMode.light;
}