import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_app/presentation/Medicine/model/Drugs.dart';
import 'package:medical_app/app/style/custom_text.dart';
import '../../../const/colors.dart';
import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../cubits/Searchcubit/search_cubit.dart';
import '../localization/localizationCubit/localization_cubit.dart';
import 'medcineInfo.dart';
import 'MedicineCubit/medicine_cubit.dart';
import 'Widgets/medicinecontainer.dart';

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

final TextEditingController searchController = TextEditingController();

class Medicine extends StatefulWidget {
  const Medicine(
      {
        super.key,
      required this.controller,
      required this.searchQuery,
      required this.localizationCubit});

  final TextEditingController controller;
  final String searchQuery;
  final LocalizationCubit localizationCubit;

  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  late SearchCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SearchCubit>(context);
    cubit.fetchMedicinePagination();
  }

  @override


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (width < 500) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
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
              text: S.of(context).Medcine1,
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.0472
                  : MediaQuery.of(context).size.width < 800
                      ? MediaQuery.of(context).size.width * 0.035
                      : MediaQuery.of(context).size.width * 0.02,
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is MedicineSearchLoading) {
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
              } else if (state is MedicineError) {
                return const Center(
                  child: Text("state.error"),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.kColorCircle,
                        borderRadius:
                            BorderRadius.circular(0.097323600973236 * width),
                      ),
                      child: TextFormField(
                        controller: widget.controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 500
                                ? MediaQuery.of(context).size.width * 0.0472
                                : MediaQuery.of(context).size.width < 800
                                    ? MediaQuery.of(context).size.width * 0.025
                                    : MediaQuery.of(context).size.width * 0.02,
                            color: const Color(0xffA1A8B0),
                          ),
                          hintText: S.of(context).Searchdrugs,
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: EdgeInsets.all(
                            MediaQuery.of(context).size.width < 500
                                ? 0.048661800486618 * width
                                : MediaQuery.of(context).size.width < 800
                                    ? 0.018661800486618 * width
                                    : 0.028661800486618 * width,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          if (value.isNotEmpty) {
                            context
                                .read<SearchCubit>()
                                .searchCubitMedicine(value);
                          }
                        },
                        onSaved: (String? value) {
                          if (value != null && value.isNotEmpty) {
                            context
                                .read<SearchCubit>()
                                .searchCubitMedicine(value);
                          }
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context
                                .read<SearchCubit>()
                                .searchCubitMedicine(value);
                          }
                        },
                      ),
                    ),
                    (!widget.controller.text.isNotEmpty)
                        ? SizedBox(
                            height: 0.025992700729927 * height,
                          )
                        : const SizedBox(),
                    (!widget.controller.text.isNotEmpty)
                        ? Row(
                            children: [
                              Text(
                                S.of(context).Medcine1,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.width <
                                          500
                                      ? MediaQuery.of(context).size.width *
                                          0.0472
                                      : MediaQuery.of(context).size.width < 800
                                          ? MediaQuery.of(context).size.width *
                                              0.041
                                          : MediaQuery.of(context).size.width *
                                              0.04,
                                ),
                              ),
                              const Spacer(),
                            ],
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 0.025992700729927 * height,
                    ),
                    Expanded(
                        child: _buildBody(context, state, currentLanguageCode)),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(
      BuildContext context, SearchState state, String currentLanguageCode) {
    if (widget.controller.text.isEmpty) {
      return _buildEmptySearchResult(context, currentLanguageCode);
    }

    if (state is MedicineSearchploading) {
      return Column(
        children: [
          Center(
            child: Lottie.asset(
              'Image/CircularIndicatorLottie.json',
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.width < 500)
                  ? 100
                  : (MediaQuery.of(context).size.width < 800)
                      ? 500
                      : 900,
            ),
          ),
        ],
      );
    }
    if (state is MedicineSearchDataSuccessful) {
      if (context.read<SearchCubit>().searchList1.isEmpty) {
        return _buildNoResultsFound(context);
      } else {
        return _buildSearchResults(context, currentLanguageCode);
      }
    }
    return _buildNoResultsFound(context);
  }

  Widget _buildEmptySearchResult(
      BuildContext context, String currentLanguageCode) {
    double width = MediaQuery.of(context).size.width;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: MediaQuery.of(context).size.width < 320
            ? (width / 2) / 200
            : MediaQuery.of(context).size.width < 500
                ? (width / 3) / 200
                : MediaQuery.of(context).size.width < 800
                    ? (width / 3) / 200
                    : (width / 4) / 200,
      ),
      itemBuilder: (context, index) {
        Drug drug = cubit.pagination[index];
        String displayName = currentLanguageCode == "ar"
            ? convertToArabicNumbers(drug.productNameArabic)
            : drug.productName;
        String displayQuantity = currentLanguageCode == "ar"
            ? convertToArabicNumbers(drug.activeIngredientUnitArabic)
            : drug.activeIngredientUnit;
        String displayActive = currentLanguageCode == "ar"
            ? convertToArabicNumbers(drug.activeIngredientStrength.toString())
            : drug.activeIngredientStrength.toString();
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MedcineInfo(
                  name: drug.productName,
                  photo: drug.photo,
                  activeIngredints: drug.activeIngredients,
                ),
              ),
            );
          },
          child: MedicineContainer(
            photo: drug.photo,
            name: displayName,
            quantatiy: displayQuantity,
            active: displayActive,
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(BuildContext context, String currentLanguageCode) {
    double width = MediaQuery.of(context).size.width;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: context.read<SearchCubit>().searchList1.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: MediaQuery.of(context).size.width < 320
            ? (width / 2) / 200
            : MediaQuery.of(context).size.width < 500
                ? (width / 3) / 200
                : MediaQuery.of(context).size.width < 800
                    ? (width / 3) / 200
                    : (width / 4) / 200,
      ),
      itemBuilder: (context, index) {
        Drug drug = context.read<SearchCubit>().searchList1[index];
        String displayName = currentLanguageCode == "ar"
            ? convertToArabicNumbers(drug.productNameArabic)
            : drug.productName;

        String displayQuantity = currentLanguageCode == "ar"
            ? convertToArabicNumbers(drug.activeIngredientUnitArabic)
            : drug.activeIngredientUnit;
        String displayActive = currentLanguageCode == "ar"
            ? convertToArabicNumbers(drug.activeIngredientStrength.toString())
            : drug.activeIngredientStrength.toString();
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MedcineInfo(
                  name: drug.productName,
                  photo: drug.photo,
                  activeIngredints: drug.activeIngredients,
                ),
              ),
            );
          },
          child: MedicineContainer(
            photo: drug.photo,
            name: displayName,
            quantatiy: displayQuantity,
            active: displayActive,
          ),
        );
      },
    );
  }

  Widget _buildNoResultsFound(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: (1 / 3.4) * MediaQuery.of(context).size.height,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "No Results Found", // Use localization if available
              fontSize: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.0472
                  : MediaQuery.of(context).size.width < 1100
                      ? MediaQuery.of(context).size.width * 0.05
                      : MediaQuery.of(context).size.width * 0.02,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
