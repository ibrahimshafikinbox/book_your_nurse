import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/shared_preferences.dart';
import '../../../const/colors.dart';
import '../../../const/navigations.dart';
import '../Bottom/bottom.dart';
import '../Bottom/bottom_nav_docotor.dart';
import 'login_or_sign_up.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = 'splash screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    int? isViewed = sharedPreferences!.getInt('onboarding');
    Timer(
        const Duration(
          seconds: 5,
        ), () {
      if (isViewed != 0) {
        pushNamed(context, Onboarding.id);
      } else if (FirebaseAuth.instance.currentUser == null) {
        pushNamed(context, LoginOrSignUp.id);
      } else {
        // Check userType from sharedPreferences
        String? userType = sharedPreferences!.getString('userType');
        if (userType == 'nurse') {
          pushNamed(context, BottomNavDocotor.id);
        } else {
          pushNamed(context, Bottombar.id);
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.kPrimaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'Image/logosvg.svg',
                colorFilter: const ColorFilter.mode(AppColor.kWhite, BlendMode.srcIn),
                height: 129.51,
                width: 129.53,
              ),
              Text(
                'Medics',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 50.11,
                  color: AppColor.kWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
