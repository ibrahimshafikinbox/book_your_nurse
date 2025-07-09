import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/presentation/auth/sign_up_screen.dart';

import '../../../const/colors.dart';
import '../../../const/navigations.dart';
import '../../app/style/custom_button.dart';
import '../../app/style/custom_text.dart';
import 'login_screen.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});
  static String id = 'login or sign up';

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  @override
  void initState() {
    // FlutterNativeSplash.remove();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width / 10,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'Image/logosvg.svg',
                colorFilter: const ColorFilter.mode(AppColor.kPrimaryColor, BlendMode.srcIn),
                height: height / 8.7,
                width: height / 8.7,
              ),
              CustomText(
                text: 'Medics',
                fontWeight: FontWeight.w600,
                fontSize: width / 15,
                colorText: AppColor.kPrimaryColor,
              ),
              SizedBox(
                height: height / 22,
              ),
              Text(
                "Let's get started!",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: width / 18,
                  color: AppColor.kText1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                  text: "Login to enjoy the features we've provided, and stay healthy!",
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                fontSize: width / 22,
                colorText: AppColor.kText2,
                maxLines: 2,
              ),
              SizedBox(
                height: height / 16,
              ),
              CustomButton(
                onTap: (){
                  pushNamed(
                    context,
                    Login.id,
                  );
                },
                height: height / 12,
                width: width / 1.35,
                  text: 'Login',
                color: AppColor.kPrimaryColor1,
                borderRadius: BorderRadius.circular(32),
                fontSize: width / 22,
                colorText: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: height / 50,
              ),
              CustomButton(
                onTap: () {
                  pushNamed(
                    context,
                    SignUp.id,
                  );
                },
                height: height / 12,
                width: width / 1.35,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: AppColor.kPrimaryColor1,
                ),
                  text: 'Sign Up',
                fontSize: width / 22,
                colorText: AppColor.kPrimaryColor1,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
