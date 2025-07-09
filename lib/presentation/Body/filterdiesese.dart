import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_app/presentation/localization/localizationCubit/localization_cubit.dart';
import '../../../generated/l10n.dart';
import '../../app/style/custom_text.dart';
import 'Body_cubit/body_cubit.dart';
import 'disease.dart';
import 'Widget/diseasetile.dart';

class FilterDisease extends StatelessWidget {
  const FilterDisease({
    super.key,
    required this.symptoms,
    required this.numberOfSymptoms,
    required this.name,
  });

  final List<String> symptoms;
  final int numberOfSymptoms;
  final String name;

  @override
  Widget build(BuildContext context) {
    final bodyCubit = BlocProvider.of<BodyCubit>(context);
    bodyCubit.getfilterenglish(symptoms, name);
    bodyCubit.getfilterarabic(symptoms, name);
    Set<String> selectedDiseases = {};


    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: CustomText(
          text: S.of(context).Disease,
          fontSize: MediaQuery.of(context).size.width < 500
              ? MediaQuery.of(context).size.width * 0.0472
              : MediaQuery.of(context).size.width < 800
              ? MediaQuery.of(context).size.width * 0.035
              : MediaQuery.of(context).size.width * 0.02,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, langState) {
          String currentLanguageCode = 'en';
          if (langState is ChangeLanguage && langState.languageCode != null) {
            currentLanguageCode = langState.languageCode!;
          }
          return BlocBuilder<BodyCubit, BodyState>(
            builder: (context, state) {
              if (state is BodyLoading) {
                return Center(
                  child: Lottie.asset(
                    'Image/CircularIndicatorLottie.json',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width < 500
                        ? 100
                        : MediaQuery.of(context).size.width < 1100
                        ? 500
                        : 900,
                  ),
                );
              } else if (state is BodyFailed) {
                return Center(child: Text(state.errorMessage));
              } else  {
                final diseaseList = currentLanguageCode == 'ar'
                    ? bodyCubit.nameOfDiseaseArabic
                    : bodyCubit.nameOfDisease;

                if (diseaseList.isEmpty) {
                  return Center(
                    child: CustomText(
                      text: S.of(context).Thelistisempty,
                      fontSize: MediaQuery.of(context).size.width < 500
                          ? MediaQuery.of(context).size.width * 0.0472
                          : MediaQuery.of(context).size.width < 1100
                          ? MediaQuery.of(context).size.width * 0.05
                          : MediaQuery.of(context).size.width * 0.02,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: diseaseList.length,
                  itemBuilder: (context, index) {
                    final bodyOrigin = diseaseList[index];
                    final totalSymptoms = currentLanguageCode == 'ar'
                        ? bodyOrigin.symptomsArabic.length
                        : bodyOrigin.symptoms.length;
                    final matchedSymptoms = symptoms.where((symptom) {
                      return (currentLanguageCode == 'ar'
                          ? bodyOrigin.symptomsArabic
                          : bodyOrigin.symptoms).contains(symptom);
                    }).length;
                    final percentage =
                    (matchedSymptoms / totalSymptoms * 100).round();

                    if (percentage == 0) {
                      return const SizedBox.shrink(); // Skip items with 0% match
                    }

                    return DiseaseTile(
                      diseaseName: currentLanguageCode == 'ar'
                          ? bodyOrigin.diseaseArabic
                          : bodyOrigin.disease,
                      diseaseNameArabic: bodyOrigin.diseaseArabic,
                      percentage: percentage,
                      currentLanguageCode: currentLanguageCode,
                      isSelected: selectedDiseases.contains(bodyOrigin.disease),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DiseasePage(
                            disease: bodyOrigin.disease,
                            diseaseArabic: bodyOrigin.diseaseArabic,
                            part: bodyOrigin.part,
                          ),
                        ));
                        selectedDiseases.add(bodyOrigin.disease);
                        bodyCubit.addSelectedDisease(bodyOrigin.disease);
                      },
                    );
                  },
                );
              }

            },
          );
        },
      ),
    );
  }
}
