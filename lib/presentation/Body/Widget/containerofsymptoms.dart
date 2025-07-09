import 'package:flutter/material.dart';
import '../../../app/style/custom_text.dart';
import '../../../const/colors.dart';

class ContainerofSymptoms extends StatelessWidget {
  const ContainerofSymptoms({
    super.key,
    required this.symptoms,
    required this.isSelected,
    this.onTap,
  });

  final String symptoms;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.kPrimaryColor1 : Colors.white ,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CustomText(
          text: symptoms,
          colorText: isSelected ? Colors.white :  Colors.black,
          fontSize: MediaQuery.of(context).size.width < 500
              ? MediaQuery.of(context).size.width * 0.0472
              : MediaQuery.of(context).size.width < 1100
              ? MediaQuery.of(context).size.width * 0.05
              : MediaQuery.of(context).size.width * 0.02,
          maxLines: 60,
        ),
      ),
    );
  }
}

//AppColor.kText2
// AppColor.KColorcircle2,
// AppColor.kPrimaryColor1
