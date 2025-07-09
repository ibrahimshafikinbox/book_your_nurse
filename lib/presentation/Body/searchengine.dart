import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_app/cubits/Searchcubit/search_cubit.dart';
import 'package:medical_app/presentation/Body/diseasesearch.dart';
import '../../../generated/l10n.dart';
import '../../app/style/custom_text.dart';
import '../../const/colors.dart';
import '../localization/localizationCubit/localization_cubit.dart';
import 'model/body_origin.dart';

class SearchEngine extends StatelessWidget {
  final String searchQuery;
  final LocalizationCubit localizationCubit;
  final TextEditingController controller;

  const SearchEngine({
    super.key,
    required this.searchQuery,
    required this.localizationCubit,
    required this.controller,
  });

  static String id = 'SearchEngine';


  Widget build(BuildContext context) {
    controller.text = searchQuery;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          text: S.of(context).SearchResults,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, langState) {
          String currentLanguageCode = 'en'; // Default language code
          if (langState is ChangeLanguage && langState.languageCode != null) {
            currentLanguageCode = langState.languageCode!;
          }
          return BlocBuilder<SearchCubit,SearchState>(
            builder: (context, state) {
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

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.kColorCircle,
                        borderRadius:
                        BorderRadius.circular(0.097323600973236 * width),
                      ),
                      child: TextFormField(
                        controller: controller,
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
                          hintText: "Search with Disease name",
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
                            context.read<SearchCubit>().searchCubit(value);
                          }
                        },
                        onSaved: (searchQuery) {
                          if (searchQuery != null && searchQuery.isNotEmpty) {
                            context.read<SearchCubit>().searchCubit(searchQuery);
                          }
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context.read<SearchCubit>().searchCubit(value);
                          }
                        },
                        obscureText: false,                      ),
                    ),
                  ),

                  Expanded(
                    child: _buildBody(context, state, currentLanguageCode),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchState state, String currentLanguageCode) {
    if (controller.text.isEmpty) {
      return _buildEmptySearchResult(context);
    }

    if (state is GetSearchploading) {
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
    }
    if (state is GetSearchpData) {
      if (context.read<SearchCubit>().searchList.isEmpty) {
        return _buildNoResultsFound(context);
      } else {
        return _buildSearchResults(context, currentLanguageCode);
      }
    }
    return _buildNoResultsFound(context);
  }

  Widget _buildEmptySearchResult(BuildContext context) {
    return Center(
      child: CustomText(
        text: 'Please enter a search query',
        fontSize: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.0472
            : MediaQuery.of(context).size.width < 1100
            ? MediaQuery.of(context).size.width * 0.05
            : MediaQuery.of(context).size.width * 0.02,
      ),
    );
  }

  Widget _buildNoResultsFound(BuildContext context) {
    return Center(
      child: CustomText(
        text: 'No results found',
        fontSize: MediaQuery.of(context).size.width < 500
            ? MediaQuery.of(context).size.width * 0.0472
            : MediaQuery.of(context).size.width < 1100
            ? MediaQuery.of(context).size.width * 0.05
            : MediaQuery.of(context).size.width * 0.02,
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, String currentLanguageCode) {
    return ListView.builder(
      itemCount: context.read<SearchCubit>().searchList.length,
      itemBuilder: (context, index) {
        BodyOrigin bodyOrigin = context.read<SearchCubit>().searchList[index];

        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Diseasesearch(
                disease: bodyOrigin.disease,
                diseaseArabic: bodyOrigin.diseaseArabic,
                part: bodyOrigin.part,
              ),
            ));
          },
          child: ListTile(
            title: CustomText(
              text: currentLanguageCode == 'ar'
                  ? bodyOrigin.diseaseArabic
                  : bodyOrigin.disease,
              fontSize: MediaQuery.of(context).size.width < 500
                  ? MediaQuery.of(context).size.width * 0.0472
                  : MediaQuery.of(context).size.width < 1100
                  ? MediaQuery.of(context).size.width * 0.05
                  : MediaQuery.of(context).size.width * 0.02,
              maxLines: 3,
            ),
            subtitle: CustomText(
              text: currentLanguageCode == 'ar'
                  ? bodyOrigin.descriptionArabic
                  : bodyOrigin.description,
              maxLines: 3,
            ),
          ),
        );
      },
    );
  }
}