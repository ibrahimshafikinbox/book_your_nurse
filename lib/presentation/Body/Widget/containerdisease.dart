import 'package:flutter/cupertino.dart';

import '../../../app/style/custom_text.dart';
import '../../../const/colors.dart';

class ContainerDiseases extends StatelessWidget {
  final String text;

  const ContainerDiseases({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(

      width:width ,
      margin: EdgeInsets.all(height / 70),
      padding: EdgeInsets.only(
        left: width / 20,
        top: width / 20,
        right: width / 35,
        bottom: width / 20,
      ),
      decoration: BoxDecoration(
        color: AppColor.kText2,
        borderRadius: BorderRadius.circular(10)
        // Remove the borderRadius property to make it rectangular
      ),
      child: Column(
        children: [
          // Display each symptom in a separate text widget
          CustomText(
            text: text,
            fontWeight: FontWeight.w300,
            colorText: AppColor.kGrey1,
            fontSize: (1 / 18) * width,
            maxLines: 100,

          ),
        ],
      ),
    );
  }
}
