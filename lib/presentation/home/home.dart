import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_app/generated/l10n.dart';
import 'package:medical_app/presentation/LabTest/labtest.dart';
import 'package:medical_app/presentation/Medicine/medcine.dart';
import 'package:medical_app/presentation/home/model/Doctor.model.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/presentation/home/model/nurse_model.dart';
import 'package:medical_app/presentation/home/widget/topdoctorcontainer.dart';
import 'package:medical_app/presentation/home/widget/home_collection.dart';
import '../Body/list of body.dart';
import '../DoctorView/DoctorView.dart';
import '../localization/localizationCubit/localization_cubit.dart';
import 'doctordetails.dart';
import 'topdoctor.dart';
import 'home_cubit/home_cubit.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'home screen';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    BlocProvider.of<HomeCubit>(context).fetchHomeData();
    final TextEditingController searchController = TextEditingController();

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is TopdoctorHomeError) {
          // Handle error state
        }
      },
      builder: (context, state) {
        if (state is TopdoctorHomeloading) {
          return Center(
            child: Lottie.asset(
              'Image/CircularIndicatorLottie.json',
              width: width,
              height: width < 500 ? 100 : width < 800 ? 500 : 900,
            ),
          );
        }
        if (state is TopdoctorHomeSuccefully) {
          return SafeArea(

            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.0487 * width,
                    vertical: 0.0461 * height,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.kColorCircle.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(0.0973 * width),
                        ),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: width < 500
                                  ? width * 0.0472
                                  : width < 800
                                  ? width * 0.025
                                  : width * 0.02,
                            ),
                            hintText: S.of(context).search_your_doctor,
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: EdgeInsets.all(
                                width < 500 ? 0.0487 * width : 0.0287 * width),
                          ),
                        ),
                      ),
                      SizedBox(height: 0.026 * height),
                      Text(
                        "${S.of(context).hi} ${FirebaseAuth.instance.currentUser?.displayName ?? ''}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: width < 500
                              ? width * 0.0472
                              : width < 800
                              ? width * 0.05
                              : width * 0.05,
                          color: AppColor.namecolor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0195 * width),
                        child: Text(
                          S.of(context).find_your_desire_health_solution,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: width < 500
                                ? width * 0.0472
                                : width < 800
                                ? width * 0.05
                                : width * 0.05,
                            color: AppColor.kText4,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Collection(
                      //       onTap: () {
                      //         Navigator.of(context).push(
                      //           MaterialPageRoute(
                      //             builder: (context) => const DoctorView(),
                      //           ),
                      //         );
                      //       },
                      //       displayText: S.of(context).find_doctor,
                      //       svg: 'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/collection%2FDoctor.svg?alt=media&token=43568163-d928-42be-a133-2b3e09b0c403',
                      //     ),
                          // SizedBox(width: 0.0487 * width),
                          // Collection(
                          //   onTap: () {
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (context) => const ChooseTheBody(),
                          //       ),
                          //     );
                          //   },
                          //   displayText: S.of(context).check_yourself,
                          //   svg: 'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/collection%2FCheckyourself.svg?alt=media&token=7f32e254-09c2-4991-be0c-f95638bf2eba',
                          // ),
                          // SizedBox(width: 0.0487 * width),
                          // Collection(
                          //   onTap: () {
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (context) => const MainScreen(),
                          //       ),
                          //     );
                          //   },
                          //   displayText: S.of(context).LabTest,
                          //   svg: 'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/collection%2FVector.svg?alt=media&token=26d36e57-0a3f-4d49-a829-0dd74fb3a159',
                          // ),
                          // SizedBox(width: 0.0487 * width),
                          // Collection(
                          //   onTap: () {
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (context) =>  Medicine(controller: searchController, searchQuery: '', localizationCubit: BlocProvider.of<LocalizationCubit>(context),),
                          //       ),
                          //     );
                          //   },
                          //   displayText: S.of(context).Medcine,
                          //   svg: 'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/collection%2FPharmacy.svg?alt=media&token=546152b8-0729-4a2c-b7db-1591e72808e0',
                          // ),
                      //   ],
                      // ),
                      SizedBox(height: 0.023 * height),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.kColorCircle,
                        ),
                        child: Text(
                          S.of(context).early_protection_for_your_family_health,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 0.0438 * width,
                          ),
                        ),
                      ),
                      SizedBox(height: 0.0288 * height),
                      Row(
                        children: [
                          Text(
                            S.of(context).nurse,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: width < 500
                                  ? width * 0.0472
                                  : width < 800
                                  ? width * 0.041
                                  : width * 0.02,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            child: Text(
                              S.of(context).see_all,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: width < 500
                                    ? width * 0.0352
                                    : width < 800
                                    ? width * 0.03
                                    : width * 0.02,
                                color: AppColor.kPrimaryColor1,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(TopDoctor.id);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 0.0288 * height),
                      SizedBox(
                        width: width,
                        height: 174,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: context.read<HomeCubit>().data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            Nurse nurse = context.read<HomeCubit>().data[index];
                            return TopDoctorContainer(
                              photoUrl: nurse.photo,
                              doctorname: nurse.nameAr,
                                city: nurse.cityEn, onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetails(nurse: nurse,
                                  ),
                                ),
                              );
                            },
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => DoctorDetails(
                              //         photoUrl: doctor.photo,
                              //         doctorName: doctor.name,
                              //         category: doctor.category,
                              //         rating: doctor.averageRating,
                              //         address: doctor.address,
                              //         city: doctor.city,
                              //         government: doctor.government,
                              //         aboutUs: doctor.about,
                              //         times: doctor.time,
                              //         reservation: doctor.reservation,
                              //         email: doctor.email,
                              //       ),
                              //     ),
                              //   );
                              // },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Center();
      },
    );
  }
}
