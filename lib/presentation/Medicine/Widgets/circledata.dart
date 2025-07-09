import 'package:flutter/cupertino.dart';
import 'package:medical_app/const/colors.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(height:10 ,width:10,  decoration:  BoxDecoration(
        color:AppColor.circlecolor,
        shape: BoxShape.circle,
        border: Border.all(width: 5.0, color:AppColor.circlecolor),
      ),),
    );
  }
}
