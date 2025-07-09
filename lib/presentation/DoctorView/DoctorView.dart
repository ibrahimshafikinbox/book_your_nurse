import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../const/colors.dart';
import '../../../generated/l10n.dart';
import '../../app/style/custom_text.dart';
import '../home/widget/home_collection.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor:Colors.white,

      appBar: AppBar(
        backgroundColor:Colors.white,
scrolledUnderElevation: 0,
        title: CustomText(
          text: S.of(context).find_doctors,
          fontSize: MediaQuery.of(context).size.width < 500
              ? MediaQuery.of(context).size.width * 0.0472
              : MediaQuery.of(context).size.width < 800
                  ? MediaQuery.of(context).size.width * 0.035
                  : MediaQuery.of(context).size.width * 0.02,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
    padding: EdgeInsets.symmetric(
    horizontal: 0.028661800486618 * width,
    vertical: 0.0201361014994233 * height,),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.kColorCircle,
                borderRadius: BorderRadius.circular(0.097323600973236 * width),
              ),
              child: TextField(
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
                  hintText: S.of(context).Searchdoctor,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: EdgeInsets.all(
                    MediaQuery.of(context).size.width < 500
                        ? 0.048661800486618 * width
                        : MediaQuery.of(context).size.width < 800
                            ? 0.018661800486618 * width
                            : 0.028661800486618 * width,
                  ),
                ),
                onSubmitted: (String value) {
                  // context.read<MedicineCubit>().searchCubitMedicine(value);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SearchMedicineEngine(
                  //       searchQuery: value,
                  //       localizationCubit: BlocProvider.of<LocalizationCubit>(context),
                  //       controller: searchController,
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
            SizedBox(
              height: 0.025992700729927 * height,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    S.of(context).Categories,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width < 500
                          ? MediaQuery.of(context).size.width *0.036
                          : MediaQuery.of(context).size.width < 800
                              ? MediaQuery.of(context).size.width * 0.0225
                              : MediaQuery.of(context).size.width * 0.015,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                    },
                    child: Text(
                      S.of(context).SeeotherCategories,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width < 500
                            ? MediaQuery.of(context).size.width * 0.0352
                            : MediaQuery.of(context).size.width < 800
                            ? MediaQuery.of(context).size.width *
                            0.03
                            : MediaQuery.of(context).size.width *
                            0.025,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Collection(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const DoctorView()));
                    },
                    displayText:"General\n",
                    svg:
                        'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/collection%2FDoctor.svg?alt=media&token=43568163-d928-42be-a133-2b3e09b0c403',
                  ),

                  Collection(
                    onTap: () {},
                    displayText: "Lungs\n",
                    svg:
                        'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/Group%20147.svg?alt=media&token=4eaba955-ae85-419d-be0b-172427e60e7f',

                  ),

                  Collection(
                    onTap: () {},
                    displayText: "Dentist\n",
                    svg:
                        'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/Dentist.svg?alt=media&token=258091f9-09aa-4ff7-aff4-07649cbc46b1',
                  ),

                  Collection(
                    onTap: () {},
                    displayText: "Psychiatrist\n",
                    svg:
                        'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/Psychiatrist.svg?alt=media&token=3a9b6e21-7930-43a9-9a1f-cf9cd061e82b',
                  ),


                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Collection(
                    onTap: () {},
                    displayText: "Surgeon\n",
                    svg:
                    'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/collection%2FVector.svg?alt=media&token=26d36e57-0a3f-4d49-a829-0dd74fb3a159',

                  ),
                  SizedBox(
                    width: 0.060001800406618 * width,
                  ),
                  Collection(
                    onTap: () {

                    },
                    displayText:"Cardiologist\n",
                    svg:
                    'https://firebasestorage.googleapis.com/v0/b/medical-app-bfe86.appspot.com/o/collection%2FDoctor.svg?alt=media&token=43568163-d928-42be-a133-2b3e09b0c403',
                  ),





                const Spacer(),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
