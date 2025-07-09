import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/app/style/custom_text.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/services/fire_chat.dart';
import '../../../const/colors.dart';
import '../../../const/navigations.dart';
import '../../../cubits/connection/connection_cubit.dart';
import '../../../generated/l10n.dart';
import '../../app/style/Custom_appbar.dart';
import '../../app/style/custom_button.dart';
import '../../app/style/custom_icon.dart';
import '../../app/style/custom_icon_button.dart';
import '../../cubits/connection/connection_state.dart';
import '../Bottom/bottom.dart';


class EditeProfile extends StatefulWidget {
  const EditeProfile({super.key});
  static String id = 'edite profile';

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {
  bool nameEdit = false;
  bool aboutEdit = false;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formFieldEditeProfile = GlobalKey<FormState>();
    final nameEditeProfileController = TextEditingController();
    final aboutEditeProfileController = TextEditingController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        toolbarHeight: height / 12,
        centerTitle: false,
        leading: CustomIconButton(
          onPressed: () {
            pushNamed(context, Bottombar.id);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.kText1,
          ),
        ),
        title: CustomText(
          text: S.of(context).edit_profile,
          colorText: AppColor.kText1,
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Form(
            key: formFieldEditeProfile,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: ListTile(
                    leading: CustomIcon(
                      icon: Icons.person_outline,
                      color: AppColor.kPrimaryColor1,
                    ),
                    trailing: CustomIconButton(
                      icon: Icon(
                        Icons.edit,
                        color: AppColor.kText3,
                      ),
                      onPressed: () {
                        setState(() {
                          nameEdit = !nameEdit;
                        });
                      },
                    ),
                    title: TextField(
                      controller: nameEditeProfileController,
                      enabled: nameEdit,
                      decoration: InputDecoration(
                        //labelText: 'Name',
                        labelStyle: GoogleFonts.inter(
                          color: AppColor.kText3,
                          fontWeight: FontWeight.w600,
                        ),
                        hintText: userModel1!.name,
                        hintStyle: GoogleFonts.inter(
                          color: nameEdit == false
                              ? AppColor.kText3
                              : AppColor.kText2,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: CustomIcon(
                      icon: Icons.notes,
                      color: AppColor.kPrimaryColor1,
                    ),
                    trailing: CustomIconButton(
                      icon: Icon(
                        Icons.edit,
                        color: AppColor.kText3,
                      ),
                      onPressed: () {
                        setState(() {
                          aboutEdit = !aboutEdit;
                        });
                      },
                    ),
                    title: TextField(
                      controller: aboutEditeProfileController,
                      enabled: aboutEdit,
                      decoration: InputDecoration(
                        //labelText: 'About',
                        labelStyle: GoogleFonts.inter(
                          color: AppColor.kText3,
                          fontWeight: FontWeight.w600,
                        ),
                        hintText: userModel1!.about,
                        hintStyle: GoogleFonts.inter(
                          color: aboutEdit == false
                              ? AppColor.kText3
                              : AppColor.kText2,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                // Card(
                //   child: ListTile(
                //     leading: CustomIcon(
                //       icon: Icons.email_outlined,
                //       color: AppColor.kPrimaryColor1,
                //     ),
                //     trailing: CustomIconButton(
                //       icon: Icon(
                //         Icons.edit,
                //         color: AppColor.kText3,
                //       ),
                //       onPressed: () {
                //         setState(() {
                //           emailEdit = !emailEdit;
                //         });
                //       },
                //     ),
                //     title: TextField(
                //       controller: emailEditeProfileController,
                //       enabled: emailEdit,
                //       decoration: InputDecoration(
                //         //labelText: 'Email',
                //         labelStyle: GoogleFonts.inter(
                //           color: AppColor.kText3,
                //           fontWeight: FontWeight.w600,
                //         ),
                //         hintText: userModel1!.email,
                //         hintStyle: GoogleFonts.inter(
                //           color: emailEdit == false
                //               ? AppColor.kText3
                //               : AppColor.kText2,
                //           fontWeight: FontWeight.w600,
                //         ),
                //         border: InputBorder.none,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: height / 20,
                ),
                BlocBuilder<InternetBloc, InternetState>(
                  builder: (context, connectState) {
                    InternetBloc internetBloc = BlocProvider.of<InternetBloc>(context);

                    if (connectState is InternetConnectedState) {
                      return CustomButton(
                        onTap: () {
                          if (nameEditeProfileController.text.isNotEmpty ||
                              aboutEditeProfileController.text.isNotEmpty) {
                            FireChat()
                                .editProfile(
                              nameEditeProfileController.text == ''
                                  ? userModel1!.name!
                                  : nameEditeProfileController.text,
                              aboutEditeProfileController.text == ''
                                  ? userModel1!.about!
                                  : aboutEditeProfileController.text,
                            )
                                .then((value) {
                              setState(() {
                                nameEdit = false;
                                aboutEdit = false;
                              });
                            });
                          }
                        },
                        height: height / 12.5,
                        width: width / 1,
                        borderRadius: BorderRadius.circular(32),
                        text: S.of(context).save,
                        color: AppColor.kPrimaryColor1,
                        colorText: AppColor.kWhite,
                        fontSize: width / 20.5,
                        fontWeight: FontWeight.w600,
                      );
                    } else if (connectState is InternetDisconnectedState) {
                      return CustomText(
                        text: "No Internet Connection",
                        colorText: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      );
                    }

                    return CustomText(
                      text: "Checking Connection...",
                      colorText: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
