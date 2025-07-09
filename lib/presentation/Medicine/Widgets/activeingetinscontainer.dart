import 'package:flutter/material.dart';
import '../../../app/style/custom_text.dart';
import '../../../const/colors.dart';
import '../activeingredints.dart';

class ActiveContainer extends StatelessWidget {
  final String drugName;
  final String description;
  final void Function()? onTap;
  final String activedata;
  final String mechanism;
  final String clinicaluse;
  final String doses;
  final String sideEffects;
  final String pharmacokinetics;
  final String contraindications;
final String druginteraction;
  const ActiveContainer({
    super.key,
    required this.drugName,
    required this.description,
    this.onTap,
    required this.activedata,
    required this.clinicaluse,
    required this.mechanism,
    required this.doses, required this.sideEffects, required this.pharmacokinetics, required this.contraindications, required this.druginteraction,
  });

  double _calculateFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 500) {
      return width * 0.0472;
    } else if (width < 1100) {
      return width * 0.05;
    } else {
      return width * 0.02;
    }
  }

  String convertToArabicNumbers(String input) {
    const englishToArabicDigits = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };
    return input.replaceAllMapped(RegExp(r'[0-9]'), (match) {
      return englishToArabicDigits[match.group(0)]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> activeDetails = [
      'Mechanism',
      'Clinical use',
      'Doses',
      'Side Effects',
      'Pharmacokinetics',
      'Contraindications',
      'Drug Interaction'
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColor.kGrey3.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                CustomText(
                  text: drugName,
                  colorText: Colors.black,
                  fontSize: _calculateFontSize(context) + 2,
                  maxLines: 5,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),


            CustomText(
              text: description,
              colorText: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: _calculateFontSize(context),
              maxLines: 1000,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ActiveIngredientsScreen(
                      activeIngredients: drugName,
                      title: activeDetails[0],
                      sub: mechanism,
                    )));
              },
              child: CustomText(
                text: activeDetails[0],
                fontSize: _calculateFontSize(context),
                fontWeight: FontWeight.w500,
                colorText: Colors.blue,
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => ActiveIngredientsScreen(
            //           activeIngredients: drugName,
            //           title: activeDetails[1],
            //           sub: clinicaluse,
            //         )));
            //   },
            //   child: CustomText(
            //     text: activeDetails[1],
            //     fontSize: _calculateFontSize(context),
            //     fontWeight: FontWeight.w500,
            //     colorText: Colors.blue,
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ActiveIngredientsScreen(
                      activeIngredients: drugName,
                      title: activeDetails[2],
                      sub: doses,
                    )));
              },
              child: CustomText(
                text: activeDetails[2],
                fontSize: _calculateFontSize(context),
                fontWeight: FontWeight.w500,
                colorText: Colors.blue,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ActiveIngredientsScreen(
                      activeIngredients: drugName,
                      title: activeDetails[3],
                      sub: sideEffects,
                    )));
              },
              child: CustomText(
                text: activeDetails[3],
                fontSize: _calculateFontSize(context),
                fontWeight: FontWeight.w500,
                colorText: Colors.blue,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ActiveIngredientsScreen(
                      activeIngredients: drugName,
                      title: activeDetails[4],
                      sub: pharmacokinetics,
                    )));
              },
              child: CustomText(
                text: activeDetails[4],
                fontSize: _calculateFontSize(context),
                fontWeight: FontWeight.w500,
                colorText: Colors.blue,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ActiveIngredientsScreen(
                      activeIngredients: drugName,
                      title: activeDetails[5],
                      sub:contraindications,
                    )));
              },
              child: CustomText(
                text: activeDetails[5],
                fontSize: _calculateFontSize(context),
                fontWeight: FontWeight.w500,
                colorText: Colors.blue,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ActiveIngredientsScreen(
                      activeIngredients: drugName,
                      title: activeDetails[6],
                      sub:druginteraction,
                    )));
              },
              child: CustomText(
                text: activeDetails[6],
                fontSize: _calculateFontSize(context),
                fontWeight: FontWeight.w500,
                colorText: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
