import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_app/cubits/Searchcubit/search_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../generated/l10n.dart';
import '../../const/colors.dart';
import '../localization/localizationCubit/localization_cubit.dart';
import 'Body_cubit/body_cubit.dart';
import 'searchengine.dart';
import 'Widget/partswomen.widget.dart';
import 'Widget/parts.widget.dart';
import 'Widget/parts2.widget.dart';

final TextEditingController searchController = TextEditingController();

class ChooseTheBody extends StatefulWidget {
  const ChooseTheBody({super.key});
  static String id = 'ChooseTheBody';

  @override
  State<ChooseTheBody> createState() => _ChooseTheBodyState();
}

class _ChooseTheBodyState extends State<ChooseTheBody> {
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!_isDataLoaded) {
      BlocProvider.of<BodyCubit>(context).getData();
      _isDataLoaded = true;
    }
  }
  @override


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final PageController boardController = PageController();
    return BlocConsumer<LocalizationCubit, LocalizationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor:Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              S.of(context).SelfCheck,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width < 500
                    ? MediaQuery.of(context).size.width * 0.0472
                    : MediaQuery.of(context).size.width < 800
                    ? MediaQuery.of(context).size.width * 0.035
                    : MediaQuery.of(context).size.width * 0.02,
              ),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<BodyCubit, BodyState>(
            builder: (context, state) {
              if (state is BodyLoading) {
                // Handle the case where data is still loading
                return Center(
                    child: Lottie.asset('Image/CircularIndicatorLottie.json',
                        width: MediaQuery.of(context).size.width,
                        height: (MediaQuery.of(context).size.width < 500)
                            ? 100
                            : (MediaQuery.of(context).size.width < 800)
                            ? 500
                            : 900));
              } else if (state is BodyFailed) {
                // Handle the case where data loading failed
                return Center(
                  child: Text(state.errorMessage),
                );
              }

              // Return a default widget in case none of the above conditions are met
              return SingleChildScrollView(
                child: Column(
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
                          controller: searchController,
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
                            hintText:  "Search with Disease name",
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

                            context.read<SearchCubit>().searchCubit(value);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchEngine(
                                  searchQuery: value,
                                  localizationCubit:
                                  BlocProvider.of<LocalizationCubit>(
                                      context),
                                  controller: searchController,
                                ),
                              ),
                            );

                          },
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.width < 500
                          ? 584
                          : MediaQuery.of(context).size.width < 800
                          ? 900
                          : 900,
                      child: PageView.builder(
                        controller: boardController,
                        itemBuilder: (BuildContext context, int index) {

                          return GestureDetector(

                            child:index==0?const PartsWidget() :index==1?const ManWidget() :const WomenWidget(),
                          );
                        },
                        itemCount:
                        context.read<BodyCubit>().bodydata!.length,
                      ),
                    ),
                    SizedBox(
                      height: 0.0346020761245675 * height,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 0.048661800486618 * width,
                        ),
                        SmoothPageIndicator(
                          controller: boardController,
                          count: 3,
                          axisDirection: Axis.horizontal,
                          effect: SlideEffect(
                            spacing: 20.0,
                            radius: 4.0,
                            dotWidth: 30.0,
                            dotHeight: 10.0,
                            paintStyle: PaintingStyle.fill,
                            strokeWidth: 1.5,
                            dotColor: const Color(0xff199A8E).withOpacity(.20),
                            activeDotColor: const Color(0xff199A8E),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}