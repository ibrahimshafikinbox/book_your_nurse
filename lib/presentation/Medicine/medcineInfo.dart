import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;
import 'package:lottie/lottie.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/presentation/Medicine/Widgets/DetailsWidget.dart';
import 'package:medical_app/presentation/Medicine/model/Drugs.dart';
import 'package:medical_app/app/style/custom_text.dart';
import 'package:medical_app/presentation/Medicine/model/activeingerdints.dart';
import '../../../generated/l10n.dart';
import '../localization/localizationCubit/localization_cubit.dart';
import 'MedicineCubit/medicine_cubit.dart';
import 'package:flutter/material.dart';
import 'Widgets/ActiveingetinsContainer.dart';
import 'Widgets/Specificationswidget.dart';
import 'Widgets/toggleMedicineButton.dart';

class MedcineInfo extends StatelessWidget {
  const MedcineInfo({
    super.key,
    required this.name,
    required this.photo,
    required this.activeIngredints,
  });

  final String name;
  final String photo;
  final List<String> activeIngredints;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var cubit = BlocProvider.of<MedicineCubit>(context);

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
        ".": ","
      };
      return input.replaceAllMapped(RegExp(r'[0-9.]'), (match) {
        return englishToArabicDigits[match.group(0)]!;
      });
    }

    // Fetch details for all active ingredients
    cubit.fetchMedicineDetails(name, photo);
    for (var activeIngredint in activeIngredints) {
      cubit.fetchActiveIngredintsDetails(activeIngredint);
    }

    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, langState) {
        String currentLanguageCode = 'en';
        if (langState is ChangeLanguage && langState.languageCode != null) {
          currentLanguageCode = langState.languageCode!;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            title: CustomText(
              text: name,
              fontSize: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.0355555555555556
                  : MediaQuery.of(context).size.width < 800
                      ? MediaQuery.of(context).size.width * 0.02
                      : MediaQuery.of(context).size.width * 0.0133333333333333,
              fontWeight: FontWeight.w600,
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<MedicineCubit, MedicineState>(
            builder: (context, state) {
              if (state is MedicineLoading) {
                return Center(
                  child: Lottie.asset(
                    'Image/CircularIndicatorLottie.json',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width < 500
                        ? 100
                        : MediaQuery.of(context).size.width < 800
                            ? 500
                            : 900,
                  ),
                );
              } else {
                if (cubit.drugDetails.isEmpty) {
                  return Center(
                    child: Lottie.asset(
                      'Image/CircularIndicatorLottie.json',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width < 500
                          ? 100
                          : MediaQuery.of(context).size.width < 800
                              ? 500
                              : 900,
                    ),
                  );
                }
                Drug drug = cubit.drugDetails[0];
                String displayName = currentLanguageCode == "ar"
                    ? convertToArabicNumbers(drug.productNameArabic)
                    : drug.productName;
                String displayQuantity = currentLanguageCode == "ar"
                    ? convertToArabicNumbers(drug.activeIngredientUnitArabic)
                    : drug.activeIngredientUnit;
                String displayActive = currentLanguageCode == "ar"
                    ? convertToArabicNumbers(
                        drug.activeIngredientStrength.toString())
                    : drug.activeIngredientStrength.toString();
                String producttype = currentLanguageCode == "ar"
                    ? drug.productTypeArabic
                    : drug.productType;

                return ValueListenableBuilder<bool>(
                  valueListenable: cubit.isShowingSpecifications,
                  builder: (context, isSpecifications, child) {
                    return ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: drug.photo, // Provide the image URL as a named parameter
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width < 500
                                  ? (1 / 3) * MediaQuery.of(context).size.height
                                  : MediaQuery.of(context).size.width < 800
                                  ? (1 / 2) * MediaQuery.of(context).size.height
                                  : MediaQuery.of(context).size.width < 1200
                                  ? (1 / 2) * MediaQuery.of(context).size.height
                                  : (1 / 2) * MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: Lottie.asset(
                                  'Image/CircularIndicatorLottie.json',
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error), // Error widget if image fails to load
                            ),

                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        text: displayName,
                                        fontWeight: FontWeight.w600,
                                        colorText: const Color(0xff101623),
                                        fontSize: (width < 322)
                                            ? 0.062111801242236 * width
                                            : (width < 500)
                                                ? width * 0.050
                                                : (width < 800)
                                                    ? 0.03125 * width
                                                    : (width < 1200)
                                                        ? 0.0208333333333333 *
                                                            width
                                                        : 0.0192307692307692 *
                                                            width,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      CustomText(
                                        text: "($producttype)",
                                        fontWeight: FontWeight.w600,
                                        colorText: const Color(0xff101623),
                                        fontSize: (width < 322)
                                            ? 0.046583850931677 * width
                                            : (width < 500)
                                                ? width * 0.030
                                                : (width < 800)
                                                    ? 0.02 * width
                                                    : (width < 1200)
                                                        ? 0.0141666666666667 *
                                                            width
                                                        : 0.0192307692307692 *
                                                            width,
                                        maxLines: 1,
                                      ),
                                      // Add some spacing
                                      const Spacer(),
                                      IconButton(
                                        icon: Icon(
                                          drug.tomydrugs.contains(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              ? Icons.delete
                                              : Icons
                                                  .add, // Fallback icon if the condition is not met
                                        ),
                                        onPressed: () {
                                          if (drug.tomydrugs.contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)) {
                                            cubit.removeFromMyMedicine(
                                                name, photo);
                                          } else {
                                            cubit.addToMyMedicine(name, photo);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      text:
                                          "${S.of(context).Price}${drug.priceInEgypt.toString()}${S.of(context).Egp}",
                                      fontWeight: FontWeight.w600,
                                      colorText: const Color(0xff101623),
                                      fontSize: (width < 322)
                                          ? 0.062111801242236 * width
                                          : (width < 500)
                                              ? width * 0.030
                                              : (width < 800)
                                                  ? 0.03125 * width
                                                  : (width < 1200)
                                                      ? 0.0208333333333333 *
                                                          width
                                                      : 0.0192307692307692 *
                                                          width,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      text: "$displayActive $displayQuantity",
                                      maxLines: 3,
                                      colorText: AppColor.ratingColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: (width < 322)
                                          ? 0.0496894409937888 * width
                                          : (width < 500)
                                              ? width * 0.032
                                              : (width < 800)
                                                  ? 0.02 * width
                                                  : (width < 1200)
                                                      ? 0.0133333333333333 *
                                                          width
                                                      : 0.0123076923076923 *
                                                          width,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: width,
                              height: 60,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Togglemedicinebutton(
                                    title: S.of(context).Specifications,
                                    colorcontainer: isSpecifications
                                        ? AppColor.kPrimaryColor1
                                        : AppColor.kWhite,
                                    colorText: isSpecifications
                                        ?AppColor.kPrimaryColor1
                                        :   AppColor.kText1,
                                    onTap: () {
                                      cubit.isShowingSpecifications.value =
                                          true;
                                    },
                                  ),
                                  Togglemedicinebutton(
                                    title: S.of(context).Details,
                                    colorcontainer: isSpecifications
                                        ? AppColor.kWhite
                                        : AppColor.kPrimaryColor1,
                                    colorText: isSpecifications
                                        ?  AppColor.kText1
                                        :AppColor.kPrimaryColor1,
                                    onTap: () {
                                      cubit.isShowingSpecifications.value =
                                          false;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (isSpecifications)
                              Specificationswidget(
                                company: drug.company,
                                dosageForm: currentLanguageCode == "ar"
                                    ? drug.dosageFormArabic
                                    : drug.dosageForm,
                                activeingredints: drug.activeIngredients,
                                route: currentLanguageCode == "ar"
                                    ? drug.routeOfAdministrationArabic
                                    : drug.routeOfAdministration,
                              )
                            else
                              Detailswidget(
                                producttype: currentLanguageCode == "ar"
                                    ? drug.productTypeArabic
                                    : drug.productType,
                                classification: currentLanguageCode == "ar"
                                    ? drug.classificationArabic
                                    : drug.classification,
                                sideaffectlength:
                                    cubit.activeIngredintDetails.length,
                                itemBuilder: (context, index) {
                                  ActiveIngredients active =
                                      cubit.activeIngredintDetails[index];
                                  List activedata = [
                                    active.mechanism,
                                    currentLanguageCode == "ar"
                                        ? active.clinicalUseAR
                                        : active.clinicalUse,
                                    currentLanguageCode == "ar"
                                        ? active.dosesAR
                                        : active.doses,
                                    currentLanguageCode == "ar"
                                        ? active.sideEffectsAR
                                        : active.sideEffects,
                                    active.pharmacokinetics,
                                    active.contraindication,
                                    active.drugInteraction,
                                  ];

                                  // Display the active ingredients in order
                                  return ActiveContainer(
                                    drugName: active.drug,
                                    description: currentLanguageCode == "ar"
                                        ? active.clinicalUseAR
                                        : active.clinicalUse,
                                    activedata: activedata[index],
                                    clinicaluse: currentLanguageCode == "ar"
                                        ? active.clinicalUseAR
                                        : active.clinicalUse,
                                    mechanism: active.mechanism,
                                    doses: currentLanguageCode == "ar"
                                        ? active.dosesAR
                                        : active.doses,
                                    sideEffects: currentLanguageCode == "ar"
                                        ? active.sideEffectsAR
                                        : active.sideEffects,
                                    pharmacokinetics: active.pharmacokinetics,
                                    contraindications: active.contraindication,
                                    druginteraction: active.drugInteraction,
                                  );
                                },
                              )
                          ],
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
