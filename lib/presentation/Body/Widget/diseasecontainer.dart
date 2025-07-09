import 'package:flutter/material.dart';

import '../../../app/style/custom_text.dart';
import '../../../const/colors.dart';

class ContainerofDisease extends StatelessWidget {
  const ContainerofDisease({
    super.key, required this.disease,
  });

  final String disease;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      tileColor: AppColor.kPrimaryColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: CustomText(
        text: disease,
        colorText: Colors.white,
        fontSize: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.0472
            : MediaQuery.of(context).size.width < 1100
            ? MediaQuery.of(context).size.width * 0.05
            : MediaQuery.of(context).size.width * 0.02,
        maxLines: 60,
      ),
    );
  }
}
