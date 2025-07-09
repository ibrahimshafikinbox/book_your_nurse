import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/navigations.dart';
import 'package:medical_app/const/shared_preferences.dart';
import 'package:medical_app/presentation/auth/auth_cubit/auth_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../const/colors.dart';

import '../../../generated/l10n.dart';
import '../../responsiveclass.dart';
import 'auth_cubit/auth_states.dart';
import 'model/onboarding_model.dart';
import 'login_or_sign_up.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  static const String id = 'onboarding screen';

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController boardController = PageController();
  late List<OnBoardingModel> boarding;

  Future<void> saveOnBoarding() async {
    await sharedPreferences!.setInt('onboarding', 0);
  }

  @override
  void initState() {
    super.initState();
    // FlutterNativeSplash.remove(); // Uncomment if using FlutterNativeSplash
  }

  @override
  Widget build(BuildContext context) {
    boarding = [
      OnBoardingModel(
        image: 'Image/on_boarding1.png',
        title: S.of(context).Consult_only_with_a_doctor_you_trust,
      ),
      OnBoardingModel(
        image: 'Image/on_boarding2.png',
        title: S.of(context).Find_a_lot_of_specialist_doctors_in_one_place,
      ),
      OnBoardingModel(
        image: 'Image/on_boarding3.png',
        title: S.of(context).Get_connect_our_Online_Consultation,
      ),
    ];

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;


    return ResponsiveLayout(
       mobileScaffold: BlocBuilder<AuthCubit, AuthStates>(
    builder: (context, state) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                // You might want to add some content here
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 0.0092272202998847 * height,
                    right: 0.0194647201946472 * width),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await saveOnBoarding();
                        pushReplacementNamed(context, LoginOrSignUp.id);
                      },
                      child: Text(
                        S.of(context).Skip,
                        style: GoogleFonts.inter(
                          fontSize: width * 0.0540632603406326,
                          fontWeight: FontWeight.w400,
                          color: AppColor.kPrimaryColor1,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.024330900243309),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      boarding.length-1 == index;
                    });
                  },
                  controller: boardController,
                  itemCount: boarding.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 0.0126874279123414 * height,
                        ),
                        Image.asset(
                          boarding[index].image!,
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.791021,
                          height: MediaQuery.of(context).size.height *
                              0.3191464821222607,
                          decoration: const BoxDecoration(
                            color: AppColor.kGrey1,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(children: [
                              Text(
                                boarding[index].title!,
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  color: const Color(0xff101623),
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.048661800486618,
                                  ),
                                  SmoothPageIndicator(
                                    controller: boardController,
                                    count: boarding.length,
                                    onDotClicked: (index) => boardController
                                        .animateToPage(
                                      index,
                                      duration: const Duration(milliseconds: 600),
                                      curve: Curves.easeIn,
                                    ),
                                    effect: const ExpandingDotsEffect(
                                      dotColor: AppColor.kIndicator,
                                      activeDotColor: AppColor.kPrimaryColor1,
                                      dotHeight: 4,
                                      dotWidth: 7.4,
                                      spacing: 5,
                                      expansionFactor: 4,
                                    ),
                                  ),
                                  const Spacer(),
                                  FloatingActionButton(
                                    shape: const CircleBorder(),
                                    backgroundColor: AppColor.kPrimaryColor1,
                                    child: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async{
                                      if (index ==
                                          boarding.length - 1) {
                                        await saveOnBoarding();
                                        pushReplacementNamed(context, LoginOrSignUp.id);
                                        //setState(() {});
                                      } else {
                                        boardController.nextPage(
                                          duration: const Duration(
                                              milliseconds: 350),
                                          curve:
                                          Curves.fastLinearToSlowEaseIn,
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.048661800486618,
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
    ),
        tabletScaffold: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    // You might want to add some content here
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0.0092272202998847 * height,
                        right: 0.0194647201946472 * width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await saveOnBoarding();
                            pushReplacementNamed(context, LoginOrSignUp.id);
                          },
                          child: Text(
                            S
                                .of(context)
                                .Skip,
                            style: GoogleFonts.inter(
                              fontSize: width * 0.0540632603406326,
                              fontWeight: FontWeight.w400,
                              color: AppColor.kPrimaryColor1,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width *
                                0.024330900243309),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: boardController,
                      itemCount: boarding.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 0.0126874279123414 * height,
                            ),
                            Image.asset(
                              boarding[index].image!,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.5,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.791021,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.3191464821222607,
                              decoration: const BoxDecoration(
                                color: AppColor.kGrey1,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(children: [
                                  Text(
                                    boarding[index].title!,
                                    style: GoogleFonts.inter(
                                      fontSize: 24,
                                      color: const Color(0xff101623),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: height / 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.048661800486618,
                                      ),
                                      SmoothPageIndicator(
                                        controller: boardController,
                                        count: boarding.length,
                                        onDotClicked: (index) =>
                                            boardController
                                                .animateToPage(
                                              index,
                                              duration: const Duration(
                                                  milliseconds: 600),
                                              curve: Curves.easeIn,
                                            ),
                                        effect: const ExpandingDotsEffect(
                                          dotColor: AppColor.kIndicator,
                                          activeDotColor: AppColor
                                              .kPrimaryColor1,
                                          dotHeight: 4,
                                          dotWidth: 7.4,
                                          spacing: 5,
                                          expansionFactor: 4,
                                        ),
                                      ),
                                      const Spacer(),
                                      FloatingActionButton(
                                        shape: const CircleBorder(),
                                        backgroundColor: AppColor
                                            .kPrimaryColor1,
                                        child: const Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          if (index ==
                                              boarding.length - 1) {
                                            await saveOnBoarding();
                                            pushReplacementNamed(
                                                context, LoginOrSignUp.id);
                                            //setState(() {});
                                          } else {
                                            boardController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 750),
                                              curve:
                                              Curves.fastLinearToSlowEaseIn,
                                            );
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.048661800486618,
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }), desktopScaffold: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    // You might want to add some content here
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0.0092272202998847 * height,
                        right: 0.0194647201946472 * width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await saveOnBoarding();
                            pushReplacementNamed(context, LoginOrSignUp.id);
                          },
                          child: Text(
                            S
                                .of(context)
                                .Skip,
                            style: GoogleFonts.inter(
                              fontSize: width * 0.0540632603406326,
                              fontWeight: FontWeight.w400,
                              color: AppColor.kPrimaryColor1,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width *
                                0.024330900243309),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: boardController,
                      itemCount: boarding.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 0.0126874279123414 * height,
                            ),
                            Image.asset(
                              boarding[index].image!,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.5,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.791021,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.3191464821222607,
                              decoration: const BoxDecoration(
                                color: AppColor.kGrey1,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(children: [
                                  Text(
                                    boarding[index].title!,
                                    style: GoogleFonts.inter(
                                      fontSize: 24,
                                      color: const Color(0xff101623),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: height / 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.048661800486618,
                                      ),
                                      SmoothPageIndicator(
                                        controller: boardController,
                                        count: boarding.length,
                                        onDotClicked: (index) =>
                                            boardController
                                                .animateToPage(
                                              index,
                                              duration: const Duration(
                                                  milliseconds: 600),
                                              curve: Curves.easeIn,
                                            ),
                                        effect: const ExpandingDotsEffect(
                                          dotColor: AppColor.kIndicator,
                                          activeDotColor: AppColor
                                              .kPrimaryColor1,
                                          dotHeight: 4,
                                          dotWidth: 7.4,
                                          spacing: 5,
                                          expansionFactor: 4,
                                        ),
                                      ),
                                      const Spacer(),
                                      FloatingActionButton(
                                        shape: const CircleBorder(),
                                        backgroundColor: AppColor
                                            .kPrimaryColor1,
                                        child: const Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          if (index ==
                                              boarding.length - 1) {
                                            await saveOnBoarding();
                                            pushReplacementNamed(
                                                context, LoginOrSignUp.id);
                                            //setState(() {});
                                          } else {
                                            boardController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 750),
                                              curve:
                                              Curves.fastLinearToSlowEaseIn,
                                            );
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.048661800486618,
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
    );
  }
}
