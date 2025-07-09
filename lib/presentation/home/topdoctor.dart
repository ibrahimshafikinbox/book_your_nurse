import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/presentation/home/model/nurse_model.dart';
import 'package:medical_app/presentation/home/widget/doctordetailscontainer2.dart';
import 'package:medical_app/presentation/home/widget/topdoctorcontainer2.dart';
import '../../../generated/l10n.dart';
import 'home_cubit/home_cubit.dart';
import 'model/Doctor.model.dart';
import 'doctordetails.dart';

class TopDoctor extends StatelessWidget {
  const TopDoctor({super.key});
  static String id = 'topDoctor';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    BlocProvider.of<HomeCubit>(context).fetchHomeData();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TopdoctorHomeloading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TopdoctorHomeSuccefully) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
              centerTitle: true,
              title: Text(
                S.of(context).nurse,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 0.0535279805352798 * width,
                  color: AppColor.kText1,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(0.024330900243309 * width),
                child: Column(
                  children: [
                    SizedBox(
                      height: height , // Adjust the height as needed
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: context.read<HomeCubit>().data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          Nurse nurse = context.read<HomeCubit>().data[index];

                          return GestureDetector(
                           onTap: (){
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => DoctorDetails(nurse: nurse,
                                 ),
                               ),
                             );
                           },
                            child: DoctorDetailsContainer2(
                              photoUrl: nurse.photo,
                              doctorName: nurse.nameAr,
                              city: nurse.cityEn,

                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
