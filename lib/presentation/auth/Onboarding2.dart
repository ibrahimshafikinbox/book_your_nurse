import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../const/colors.dart';
import 'model/onboarding_model.dart';
import 'login_or_sign_up.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});
  static String id = 'onboarding2 screen';

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  final PageController _boardController = PageController();
  bool isLast = false;
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: 'Image/on_boarding1.png',
      title: 'Consult only with a doctor you trust',
    ),
    OnBoardingModel(
      image: 'Image/on_boarding2.png',
      title: 'Find a lot of specialist doctors in one place',
    ),
    OnBoardingModel(
      image: 'Image/on_boarding3.png',
      title: 'Get connect our Online Consultation',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginOrSignUp.id);
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.inter(
                      fontSize: width / 24,
                      fontWeight: FontWeight.w400,
                      color: AppColor.kText3,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 100),
            Expanded(
              child: PageView.builder(
                controller: _boardController,
                itemCount: boarding.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        boarding[index].image!,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                            40.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 321,
                          height: 190,
                          decoration: const BoxDecoration(
                            color: AppColor.kGrey1,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(children: [
                            SizedBox(
                              height: height*0.01153402,
                            ),
                            Text(
                              "${boarding[index].title!}",
                              style: GoogleFonts.inter(
                                fontSize:width*0.0058351568198395 ,
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
                                const SizedBox(
                                  width: 20,
                                ),
                                SmoothPageIndicator(
                                  controller: _boardController,
                                  count: boarding.length,
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
                                  onPressed: () {
                                    if (_boardController.page ==
                                        boarding.length - 1) {
                                      Navigator.pushNamed(
                                          context, LoginOrSignUp.id);
                                    } else {
                                      _boardController.nextPage(
                                        duration:
                                        const Duration(milliseconds: 750),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
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
  }
}
