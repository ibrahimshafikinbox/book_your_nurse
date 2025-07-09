import 'package:flutter/cupertino.dart';

import '../../../app/style/custom_text.dart';
import '../../../const/colors.dart';
import '../../../generated/l10n.dart';
import 'circledata.dart';

class Detailswidget extends StatelessWidget {
  const Detailswidget(
      {super.key,
      required this.producttype,
      required this.classification,
      required this.sideaffectlength,
      required this.itemBuilder});
  final String producttype;
  final String classification;
  final int sideaffectlength;
  final Widget Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: S.of(context).Classification,
                colorText: AppColor.kText1,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const CircleContainer(),
            CustomText(
              text: classification,
              colorText: AppColor.circlecolor,
              maxLines: 2,
            ),
          ],
        ),

        ListView.builder(
          itemCount: sideaffectlength,
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView if already in a Scrollable
          itemBuilder: itemBuilder,
        ),
      ],
    );
  }
}
