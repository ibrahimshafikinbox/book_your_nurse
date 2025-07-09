import 'package:flutter/material.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/generated/l10n.dart';
import 'package:medical_app/presentation/home/widget/tabbar_item.dart';

import '../../app/style/custom_text.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: SizedBox(width: 0),
          title: CustomText(text: S.of(context).schedule,
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width < 500
                ? MediaQuery.of(context).size.width * 0.0472
                : MediaQuery.of(context).size.width < 800
                ? MediaQuery.of(context).size.width * 0.035
                : MediaQuery.of(context).size.width * 0.02,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColor.kGrey3,
                ),
                child: TabBar(
                  isScrollable: false, // Set to false to remove arrows
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: const BoxDecoration(
                    color: AppColor.kPrimaryColor1,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xff101623),
                  tabs: getTabs(context), // Use getTabs method here
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
                child: CustomText(
                              text: S.of(context).upcoming,
                  fontSize: MediaQuery.of(context).size.width < 500
                      ? MediaQuery.of(context).size.width * 0.0352
                      : MediaQuery.of(context).size.width < 800
                      ? MediaQuery.of(context).size.width * 0.03
                      : MediaQuery.of(context).size.width * 0.02,),),

            Center(
              child: CustomText(text: S.of(context).completed,fontSize: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.0352
                  : MediaQuery.of(context).size.width < 800
                  ? MediaQuery.of(context).size.width * 0.03
                  : MediaQuery.of(context).size.width * 0.02,),
            ),
            Center(
              child: CustomText(text: S.of(context).canceled,fontSize: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.0352
                      : MediaQuery.of(context).size.width < 800
                  ? MediaQuery.of(context).size.width * 0.03
                      : MediaQuery.of(context).size.width * 0.02,),
            ),
          ],
        ),
      ),
    );
  }

  static List<Widget> getTabs(BuildContext context) {
    return [
      TabItem(
        title: S.of(context).upcoming,
      ),
      TabItem(
        title: S.of(context).completed,
      ),
      TabItem(
        title: S.of(context).canceled,
      ),
    ];
  }
}
