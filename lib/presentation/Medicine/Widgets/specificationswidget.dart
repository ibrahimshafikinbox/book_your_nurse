import 'package:flutter/cupertino.dart';
import '../../../app/style/custom_text.dart';
import '../../../const/colors.dart';
import '../../../generated/l10n.dart';
import 'activeingredintswidget.dart';
import 'circledata.dart';

class Specificationswidget extends StatelessWidget {
  const Specificationswidget({
    super.key,
    required this.company,
    required this.dosageForm,
    required this.activeingredints, required this.route,
  });

  final String company;
  final String dosageForm;
  final List<String> activeingredints; // Ensure this is typed as List<String>
final String route;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: S.of(context).Company,
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
            Expanded(
              child: CustomText(
                text: company,
                colorText: AppColor.circlecolor,
                maxLines: 2,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: S.of(context).Productconsistency,
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
              text: dosageForm,
              colorText: AppColor.circlecolor,
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: S.of(context).RouteofAdministration,
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
              text: route,
              colorText: AppColor.circlecolor,
              maxLines: 2,
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: S.of(context).ActiveIngredients,
                colorText: AppColor.kText1,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ],
        ),
        ActiveIngredientsWidget(
          activeIngredients: activeingredints, // Directly use activeingredints
        ),
      ],
    );
  }
}
