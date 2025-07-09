import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../generated/l10n.dart';
import '../../app/style/custom_text.dart';
import '../localization/localizationCubit/localization_cubit.dart';
import 'Body_cubit/body_cubit.dart';
import 'FilterDiesese.dart';
import 'Widget/containerofsymptoms.dart';
import 'model/body_origin.dart';

class Listsymptoms extends StatefulWidget {
  const Listsymptoms({super.key, required this.name, required this.titleappBar});
  final String name;
  final String titleappBar;

  @override
  State<Listsymptoms> createState() => _ListsymptomsState();
}

class _ListsymptomsState extends State<Listsymptoms> {
  late bool _isDataLoaded;
  Set<String> selectedSymptoms = <String>{};

  @override
  void initState() {
    super.initState();
    _isDataLoaded = false;
    _loadData();
  }

  void _loadData() {
    if (!_isDataLoaded) {
      BlocProvider.of<BodyCubit>(context).getDataName(widget.name);
      _isDataLoaded = true;
    }
  }

  @override
  void didUpdateWidget(Listsymptoms oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      _isDataLoaded = false;
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: CustomText(
          text: "${S.of(context).symptomsof} ${widget.titleappBar}",
          fontSize: MediaQuery.of(context).size.width < 500
              ? MediaQuery.of(context).size.width * 0.0472
              : MediaQuery.of(context).size.width < 800
              ? MediaQuery.of(context).size.width * 0.035
              : MediaQuery.of(context).size.width * 0.02,
          fontWeight: FontWeight.w600,

        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FilterDisease(
                    numberOfSymptoms: selectedSymptoms.length,
                    symptoms: selectedSymptoms.toList(),
                    name: widget.name,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                if (selectedSymptoms.isNotEmpty)
                  CustomText(
                    text: S.of(context).Next,
                    fontSize: MediaQuery.of(context).size.width < 500
                        ? MediaQuery.of(context).size.width * 0.0472
                        : MediaQuery.of(context).size.width < 800
                        ? MediaQuery.of(context).size.width * 0.05
                        : MediaQuery.of(context).size.width * 0.02,
                  ),
                if (selectedSymptoms.isNotEmpty) const SizedBox(width: 2),
                if (selectedSymptoms.isNotEmpty)
                  Icon(
                    Icons.navigate_next,
                    size: MediaQuery.of(context).size.width < 500
                        ? MediaQuery.of(context).size.width * 0.0472
                        : MediaQuery.of(context).size.width < 800
                        ? MediaQuery.of(context).size.width * 0.05
                        : MediaQuery.of(context).size.width * 0.02,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<BodyCubit, BodyState>(
        builder: (context, state) {
          if (state is BodyLoading) {
            return Center(
                child: Lottie.asset('Image/CircularIndicatorLottie.json',
                    width: MediaQuery.of(context).size.width, height: (MediaQuery.of(context).size.width<500)?100:(MediaQuery.of(context).size.width<800)?500:900)
            );
          }  else if (state is BodyFailed) {
            return Center(child: Text(state.errorMessage));
          }
          else  {
            String currentLanguageCode = 'en';
            final langState = context.read<LocalizationCubit>().state;
            if (langState is ChangeLanguage && langState.languageCode != null) {
              currentLanguageCode = langState.languageCode!;
            }

            List<String> allEnglishSymptoms = [];
            List<String> allArabicSymptoms = [];
            final List<BodyOrigin>? data2 =
            context.select((BodyCubit cubit) => cubit.getdataname);

            if (data2 != null) {
              for (BodyOrigin bodyOrigin in data2) {
                List<String> symptomsToAdd = currentLanguageCode == 'ar'
                    ? bodyOrigin.symptomsArabic
                    : bodyOrigin.symptoms;

                if (currentLanguageCode == 'ar') {
                  allArabicSymptoms.addAll(symptomsToAdd);
                } else {
                  allEnglishSymptoms.addAll(symptomsToAdd);
                }
              }
            }

            allEnglishSymptoms = allEnglishSymptoms.toSet().toList();
            allArabicSymptoms = allArabicSymptoms.toSet().toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                allEnglishSymptoms.isNotEmpty
                    ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return
                        ContainerofSymptoms(
                          symptoms: allEnglishSymptoms[index],
                          isSelected: selectedSymptoms
                              .contains(allEnglishSymptoms[index]),
                          onTap: () {
                            setState(() {
                              if (selectedSymptoms
                                  .contains(allEnglishSymptoms[index])) {
                                selectedSymptoms
                                    .remove(allEnglishSymptoms[index]);
                              } else {
                                selectedSymptoms
                                    .add(allEnglishSymptoms[index]);
                              }
                            });
                          },
                        );
                    },
                    itemCount: allEnglishSymptoms.length,
                  ),
                )
                    : Container(),
                allArabicSymptoms.isNotEmpty
                    ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ContainerofSymptoms(
                        symptoms: allArabicSymptoms[index],
                        isSelected: selectedSymptoms
                            .contains(allArabicSymptoms[index]),
                        onTap: () {
                          setState(() {
                            if (selectedSymptoms
                                .contains(allArabicSymptoms[index])) {
                              selectedSymptoms
                                  .remove(allArabicSymptoms[index]);
                            } else {
                              selectedSymptoms
                                  .add(allArabicSymptoms[index]);
                            }
                          });
                        },
                      );
                    },
                    itemCount: allArabicSymptoms.length,
                  ),
                )
                    : Container(),
              ],
            );
          }
        },
      ),
    );
  }
}