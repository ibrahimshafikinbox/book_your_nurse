import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../generated/l10n.dart';
import '../../app/style/custom_text.dart';
import '../localization/localizationCubit/localization_cubit.dart';
import 'Body_cubit/body_cubit.dart';
import 'Widget/dieseas_new_continer.dart';
import 'model/body_origin.dart';

class DiseasePage extends StatelessWidget {

  const DiseasePage({
    super.key,
    required this.disease,
    required this.diseaseArabic,
    required this.part,
  });
  final String disease;
  final String diseaseArabic;
  final String part;
  @override
  Widget build(BuildContext context) {
    final bodyCubit = BlocProvider.of<BodyCubit>(context);
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, langState) {
        String currentLanguageCode = 'en';
        if (langState is ChangeLanguage && langState.languageCode != null) {
        currentLanguageCode = langState.languageCode!;
        }
        return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: CustomText(
              text: currentLanguageCode == 'ar' ? diseaseArabic : disease,
              fontSize: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.0472
                  : MediaQuery.of(context).size.width < 800
                  ? MediaQuery.of(context).size.width * 0.035
                  : MediaQuery.of(context).size.width * 0.02,
              fontWeight: FontWeight.w600,
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<BodyCubit, BodyState>(
            builder: (context, state) {
              if (state is BodyLoading) {
                return Center(
                  child: Lottie.asset(
                    'Image/CircularIndicatorLottie.json',
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.width < 500)
                        ? 100
                        : (MediaQuery.of(context).size.width < 800)
                            ? 500
                            : 900,
                  ),
                );
              } else {
                BodyOrigin bodyOrigin = bodyCubit.nameOfDisease
                    .first; // Display the first or selected disease

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [


                        DieseasNewcontiner(
                            title: S.of(context).Description,
                            details: currentLanguageCode == 'ar'
                                ? bodyOrigin.descriptionArabic
                                : bodyOrigin.description),
                        DieseasNewcontiner(
                            title: S.of(context).symptomsof,
                            details: currentLanguageCode == 'ar'
                                ? bodyOrigin.symptomsArabic.join(" و ")
                                : bodyOrigin.symptoms.join(",")),
                        DieseasNewcontiner(
                            title: S.of(context).Diagnosis,
                            details: currentLanguageCode == 'ar'
                                ? bodyOrigin.diagnosisArabic
                                : bodyOrigin.diagnosis),
                        DieseasNewcontiner(
                            title: S.of(context).Causes,
                            details: currentLanguageCode == 'ar'
                                ? bodyOrigin.causesArabic
                                : bodyOrigin.causes),
                        DieseasNewcontiner(
                            title: S.of(context).recommendedtreatment,
                            details: currentLanguageCode == 'ar'
                                ? bodyOrigin.recommendedTreatmentArabic
                                : bodyOrigin.recommendedTreatment),
                        DieseasNewcontiner(
                            title: S.of(context).PreventiveMeasures,
                            details: currentLanguageCode == 'ar'
                                ? bodyOrigin.preventiveMeasuresArabic
                                    .join(" و ")
                                : bodyOrigin.preventiveMeasures.join(",")),

                        // DieseasNewcontiner(
                        //     title: S.of(context).AnatomicalLocation,
                        //     details: currentLanguageCode == 'ar' ? bodyOrigin.anatomicalLocationArabic : bodyOrigin.anatomicalLocation),
                        DieseasNewcontiner(
                            title: S.of(context).FirstAid,
                            details:" ${currentLanguageCode == 'ar' ? bodyOrigin.firstAidArabic : bodyOrigin.firstAid}."),
                        DieseasNewcontiner(
                            title: S.of(context).whenToConsultProfessional,
                            details: currentLanguageCode == 'ar'
                                ? bodyOrigin.whenToConsultProfessionalArabic
                                : bodyOrigin.whenToConsultProfessional),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}