import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../generated/l10n.dart';
import '../../app/style/custom_text.dart';
import '../localization/localizationCubit/localization_cubit.dart';
import 'Body_cubit/body_cubit.dart';
import 'Widget/dieaseinfo.dart';
import 'model/body_origin.dart';

class Diseasesearch extends StatelessWidget {
  const Diseasesearch({
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
    // final double width = MediaQuery.of(context).size.width;
    // final double height = MediaQuery.of(context).size.height;

    final bodyCubit = BlocProvider.of<BodyCubit>(context);
    bodyCubit.getDieseaseName(disease);

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
                  ? MediaQuery.of(context).size.width * 0.05
                  : MediaQuery.of(context).size.width * 0.02,
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<BodyCubit, BodyState>(
            builder: (context, state) {
              if (state is BodyLoading) {
                return Center(
                    child: Lottie.asset('Image/CircularIndicatorLottie.json',
                        width: MediaQuery.of(context).size.width, height: (MediaQuery.of(context).size.width<500)?100:(MediaQuery.of(context).size.width<800)?500:900)
                );
              } else if (state is BodySuccess) {
                return ListView.builder(
                  itemCount:  bodyCubit.nameOfDisease.length,
                  itemBuilder: (BuildContext context, int index) {
                    BodyOrigin bodyOrigin = bodyCubit.nameOfDisease[index];
                    return Column(
                      children: [
                        DiseaseInfo(
                            info:
                            "${S.of(context).Description}:${currentLanguageCode == 'ar' ? bodyOrigin.descriptionArabic : bodyOrigin.description} ."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).symptomsof}:${currentLanguageCode == 'ar' ? bodyOrigin.symptomsArabic.join(" و ") : bodyOrigin.symptoms.join(",")}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).Diagnosis}:${currentLanguageCode == 'ar' ? bodyOrigin.diagnosisArabic : bodyOrigin.diagnosis}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).Causes}:${currentLanguageCode == 'ar' ? bodyOrigin.causesArabic : bodyOrigin.causes}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).Causes}:${currentLanguageCode == 'ar' ? bodyOrigin.recommendedTreatmentArabic : bodyOrigin.recommendedTreatment}."),

                        DiseaseInfo(
                            info:
                            "${S.of(context).PreventiveMeasures}:${currentLanguageCode == 'ar' ? bodyOrigin.preventiveMeasuresArabic.join(" و ") : bodyOrigin.preventiveMeasures.join(",")}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).whenToConsultProfessional}:${currentLanguageCode == 'ar' ? bodyOrigin.whenToConsultProfessionalArabic : bodyOrigin.whenToConsultProfessional}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).AnatomicalLocation}:${currentLanguageCode == 'ar' ? bodyOrigin.anatomicalLocationArabic : bodyOrigin.anatomicalLocation}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).FirstAid}:${currentLanguageCode == 'ar' ? bodyOrigin.firstAidArabic : bodyOrigin.firstAid}."),
                      ],
                    );
                  },
                );
              } else if (state is BodyFailed) {
                return Center(
                    child: Lottie.asset('Image/CircularIndicatorLottie.json',
                        width: MediaQuery.of(context).size.width, height: (MediaQuery.of(context).size.width<500)?100:(MediaQuery.of(context).size.width<800)?500:900)
                );
              }else{
                return ListView.builder(
                  itemCount:  bodyCubit.nameOfDisease.length,
                  itemBuilder: (BuildContext context, int index) {
                    BodyOrigin bodyOrigin = bodyCubit.nameOfDisease[index];
                    return Column(
                      children: [
                        DiseaseInfo(
                            info:
                            "${S.of(context).Description}:${currentLanguageCode == 'ar' ? bodyOrigin.descriptionArabic : bodyOrigin.description} ."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).symptomsof}:${currentLanguageCode == 'ar' ? bodyOrigin.symptomsArabic.join(" و ") : bodyOrigin.symptoms.join(",")}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).Diagnosis}:${currentLanguageCode == 'ar' ? bodyOrigin.diagnosisArabic : bodyOrigin.diagnosis}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).Causes}:${currentLanguageCode == 'ar' ? bodyOrigin.causesArabic : bodyOrigin.causes}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).Causes}:${currentLanguageCode == 'ar' ? bodyOrigin.recommendedTreatmentArabic : bodyOrigin.recommendedTreatment}."),

                        DiseaseInfo(
                            info:
                            "${S.of(context).PreventiveMeasures}:${currentLanguageCode == 'ar' ? bodyOrigin.preventiveMeasuresArabic.join(" و ") : bodyOrigin.preventiveMeasures.join(",")}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).whenToConsultProfessional}:${currentLanguageCode == 'ar' ? bodyOrigin.whenToConsultProfessionalArabic : bodyOrigin.whenToConsultProfessional}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).AnatomicalLocation}:${currentLanguageCode == 'ar' ? bodyOrigin.anatomicalLocationArabic : bodyOrigin.anatomicalLocation}."),
                        DiseaseInfo(
                            info:
                            "${S.of(context).FirstAid}:${currentLanguageCode == 'ar' ? bodyOrigin.firstAidArabic : bodyOrigin.firstAid}."),
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