import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/validations.dart';
import '../../../const/colors.dart';
import '../../../const/navigations.dart';
import '../../app/style/Custom_appbar.dart';
import '../../app/style/custom_button.dart';
import '../../app/style/custom_icon_button.dart';
import '../../app/style/custom_text.dart';
import '../../app/style/custom_text_form_field.dart';


import '../Bottom/bottom.dart';

class UpdateToDoctor extends StatefulWidget {
  const UpdateToDoctor({super.key});
  static String id = 'update doctor';

  @override
  State<UpdateToDoctor> createState() => _UpdateToDoctorState();
}

class _UpdateToDoctorState extends State<UpdateToDoctor> {
  late final formFieldEditeToDoctor = GlobalKey<FormState>();
  late final nameEditeToDoctorController;
  late final nameArabicEditeToDoctorController;
  late final aboutEditeToDoctorController;
  late final aboutArabicEditeToDoctorController;
  late final categoryEditeToDoctorController;
  late final categoryArabicEditeToDoctorController;
  late final cityEditeToDoctorController;
  late final cityArabicEditeToDoctorController;
  late final streetEditeToDoctorController;
  late final streetArabicEditeToDoctorController;
  late final governmentEditeToDoctorController;
  late final governmentArabicEditeToDoctorController;

  @override
  void initState() {
    nameEditeToDoctorController = TextEditingController();
    nameArabicEditeToDoctorController = TextEditingController();
    aboutEditeToDoctorController = TextEditingController();
    aboutArabicEditeToDoctorController = TextEditingController();
    categoryEditeToDoctorController = TextEditingController();
    categoryArabicEditeToDoctorController = TextEditingController();
    cityEditeToDoctorController = TextEditingController();
    cityArabicEditeToDoctorController = TextEditingController();
    streetEditeToDoctorController = TextEditingController();
    streetArabicEditeToDoctorController = TextEditingController();
    governmentEditeToDoctorController = TextEditingController();
    governmentArabicEditeToDoctorController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameEditeToDoctorController.dispose();
    nameArabicEditeToDoctorController.dispose();
    aboutEditeToDoctorController.dispose();
    aboutArabicEditeToDoctorController.dispose();
    categoryEditeToDoctorController.dispose();
    categoryArabicEditeToDoctorController.dispose();
    cityEditeToDoctorController.dispose();
    cityArabicEditeToDoctorController.dispose();
    streetEditeToDoctorController.dispose();
    streetArabicEditeToDoctorController.dispose();
    governmentEditeToDoctorController.dispose();
    governmentArabicEditeToDoctorController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bool pending;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        toolbarHeight: height / 12,
        centerTitle: false,
        leading: CustomIconButton(
          onPressed: () {
            pushNamed(context, Bottombar.id);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.kText1,
          ),
        ),
        title: const CustomText(
          text: 'Update to Doctor',
          colorText: AppColor.kText1,
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Form(
            key: formFieldEditeToDoctor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  hintText: 'Name doctor(EN)',
                  controller: nameEditeToDoctorController,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  hintStyle: GoogleFonts.inter(
                    color: AppColor.kText3,
                    fontSize: width / 30,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: CustomIconButton(
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {},
                  ),
                  validate: (value) {
                    return MyValidators.englishValidator(value);
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                CustomTextFormField(
                  hintText: 'Name doctor(AR)',
                  controller: nameArabicEditeToDoctorController,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  hintStyle: GoogleFonts.inter(
                    color: AppColor.kText3,
                    fontSize: width / 30,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: CustomIconButton(
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {},
                  ),
                  validate: (value) {
                    return MyValidators.arabicValidator(value);
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 2.3,
                      child: CustomTextFormField(
                        hintText: 'City doctor(EN)',
                        controller: cityEditeToDoctorController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintStyle: GoogleFonts.inter(
                          color: AppColor.kText3,
                          fontSize: width / 33,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: CustomIconButton(
                          icon: const Icon(Icons.location_city_outlined),
                          onPressed: () {},
                        ),
                        validate: (value) {
                          return MyValidators.englishValidator(value);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: width / 2.3,
                      child: CustomTextFormField(
                        hintText: 'City doctor(AR)',
                        controller: cityArabicEditeToDoctorController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintStyle: GoogleFonts.inter(
                          color: AppColor.kText3,
                          fontSize: width / 33,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: CustomIconButton(
                          icon: const Icon(Icons.location_city_outlined),
                          onPressed: () {},
                        ),
                        validate: (value) {
                          return MyValidators.arabicValidator(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 46,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 2.3,
                      child: CustomTextFormField(
                        hintText: 'Street doctor(EN)',
                        controller: streetEditeToDoctorController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintStyle: GoogleFonts.inter(
                          color: AppColor.kText3,
                          fontSize: width / 33,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: CustomIconButton(
                          icon: const Icon(Icons.location_on),
                          onPressed: () {},
                        ),
                        validate: (value) {
                          return MyValidators.englishValidator(value);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: width / 2.3,
                      child: CustomTextFormField(
                        hintText: 'Street doctor(AR)',
                        controller: streetArabicEditeToDoctorController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintStyle: GoogleFonts.inter(
                          color: AppColor.kText3,
                          fontSize: width / 33,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: CustomIconButton(
                          icon: const Icon(Icons.location_on),
                          onPressed: () {},
                        ),
                        validate: (value) {
                          return MyValidators.arabicValidator(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 46,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 2.3,
                      child: CustomTextFormField(
                        hintText: 'Category doctor(EN)',
                        controller: categoryEditeToDoctorController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintStyle: GoogleFonts.inter(
                          color: AppColor.kText3,
                          fontSize: width / 33,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: CustomIconButton(
                          icon: const Icon(Icons.category_outlined),
                          onPressed: () {},
                        ),
                        validate: (value) {
                          return MyValidators.englishValidator(value);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: width / 2.3,
                      child: CustomTextFormField(
                        hintText: 'Category doctor(AR)',
                        controller: categoryArabicEditeToDoctorController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintStyle: GoogleFonts.inter(
                          color: AppColor.kText3,
                          fontSize: width / 33,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: CustomIconButton(
                          icon: const Icon(Icons.category_outlined),
                          onPressed: () {},
                        ),
                        validate: (value) {
                          return MyValidators.arabicValidator(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 46,
                ),
                CustomTextFormField(
                  hintText: 'Government doctor(EN)',
                  controller: governmentEditeToDoctorController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  hintStyle: GoogleFonts.inter(
                    color: AppColor.kText3,
                    fontSize: width / 30,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: CustomIconButton(
                    icon: const Icon(Icons.school),
                    onPressed: () {},
                  ),
                  validate: (value) {
                    return MyValidators.englishValidator(value);
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                CustomTextFormField(
                  hintText: 'Government doctor(AR)',
                  controller: governmentArabicEditeToDoctorController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  hintStyle: GoogleFonts.inter(
                    color: AppColor.kText3,
                    fontSize: width / 30,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: CustomIconButton(
                    icon: const Icon(Icons.school),
                    onPressed: () {},
                  ),
                  validate: (value) {
                    return MyValidators.arabicValidator(value);
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                CustomTextFormField(
                  hintText: 'About doctor(EN)',
                  controller: aboutEditeToDoctorController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  maxLine: 5,
                  hintStyle: GoogleFonts.inter(
                    color: AppColor.kText3,
                    fontSize: width / 30,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: CustomIconButton(
                    icon: const Icon(Icons.notes),
                    onPressed: () {},
                  ),
                  validate: (value) {
                    return MyValidators.englishValidator(value);
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                CustomTextFormField(
                  maxLine: 5,
                  hintText: 'About doctor(AR)',
                  controller: aboutArabicEditeToDoctorController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  hintStyle: GoogleFonts.inter(
                    color: AppColor.kText3,
                    fontSize: width / 30,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: CustomIconButton(
                    icon: const Icon(Icons.category_outlined),
                    onPressed: () {},
                  ),
                  validate: (value) {
                    return MyValidators.arabicValidator(value);
                  },
                ),
                SizedBox(
                  height: height / 46,
                ),
                CustomButton(
                  height: height / 12.5,
                  width: width / 1,
                  borderRadius: BorderRadius.circular(32),
                  text: 'Order',
                  color: AppColor.kPrimaryColor1,
                  colorText: AppColor.kWhite,
                  fontSize: width / 20.5,
                  fontWeight: FontWeight.w600,
                    onTap: () async {
                      if (formFieldEditeToDoctor.currentState!.validate()) {
                        await FirebaseFirestore.instance.collection('Doctor').doc(FirebaseAuth.instance.currentUser!.uid).set({
                          'name': FirebaseAuth.instance.currentUser!.displayName,
                          'DrName': nameEditeToDoctorController.text,
                          'DrNameArabic': nameArabicEditeToDoctorController.text,
                        });

                        setState(() {
                          // Perform any state update if necessary
                        });
                      }
                    }

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
