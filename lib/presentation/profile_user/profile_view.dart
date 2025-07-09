// UI improvements only, logic unchanged.

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medical_app/presentation/Notification/naotification_view.dart';
import 'package:medical_app/presentation/localization/localizationCubit/localization_cubit.dart';
import 'package:medical_app/presentation/profile_user/update_to_doctor.dart';
import 'package:medical_app/presentation/profile_user/widget/textbutton.dart';
import 'package:medical_app/presentation/profile_user/widget/row_reusable.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/const/colors.dart';

import '../../../const/navigations.dart';
import '../../../const/show_dialog.dart';
import '../../../cubits/connection/connection_cubit.dart';
import '../../../generated/l10n.dart';
import '../../cubits/connection/connection_event.dart';
import '../../cubits/connection/connection_state.dart';
import '../localization/model/localization.dart';
import 'model/user_model.dart';
import '../../app/style/custom_icon.dart';
import '../../app/style/custom_icon_button.dart';
import '../../app/style/custom_text.dart';
import '../auth/login_or_sign_up.dart';
import 'edite_profile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static String id = 'profile';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    userModel;
    super.initState();
  }

  File? file;
  // Image/user.png
  Future getImage() async {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    final ImagePicker imagePicker = ImagePicker();
    final XFile? imageGallery = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageGallery != null) {
      file = File(imageGallery.path);
      var imageName = basename(imageGallery.path);
      var refStorage =
          FirebaseStorage.instance.ref('imageProfile').child(imageName);
      await refStorage.putFile(file!);
      urlImage = await refStorage.getDownloadURL();
      // await  FirebaseFirestore.instance
      //     .collection(kUsersCollections)
      //     .doc(myId)
      //     .set(userModel1!.toJson());
      //userModel!.image = urlImage;
      await FirebaseFirestore.instance
          .collection(kUsersCollections)
          .doc(myId)
          .update({kImage: urlImage});
      file = null;
      setState(() {});
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  Future<bool> userGoogle = GoogleSignIn().isSignedIn();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(kUsersCollections)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          userModel1 = UserModel.fromJson(snapshot.data!.data()!);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(color: AppColor.kGreen2),
                child: Padding(
                  padding: const EdgeInsets.only(top: 91),
                  child: BlocBuilder<InternetBloc, InternetState>(
                    builder: (context, connectState) {
                      InternetBloc internetBloc = BlocProvider.of<InternetBloc>(
                        context,
                      );
                      if (connectState is InternetConnectedState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile Picture with improved UI
                            Center(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Material(
                                    elevation: 8,
                                    shape: const CircleBorder(),
                                    child: CircleAvatar(
                                      radius: 65,
                                      backgroundColor: Colors.white,
                                      child: (urlImage != null)
                                          ? ClipOval(
                                              child: Image.network(
                                                urlImage!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : (userModel1!.image != null &&
                                                  userModel1!.image!.isNotEmpty)
                                              ? ClipOval(
                                                  child: Image.network(
                                                    userModel1!.image!,
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey[200],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    child: Image.asset(
                                                      "Image/user.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                    ),
                                  ),
                                  // Edit icon, precisely positioned and visually clear
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () async {
                                        await getImage().then((value) {
                                          if (urlImage != null) {
                                            FirebaseAuth.instance.currentUser!
                                                .updatePhotoURL(urlImage);
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Name
                            CustomText(
                              text: userModel1!.name ?? '',
                              colorText: AppColor.kWhite,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            const SizedBox(height: 6),
                            // Email
                            (userModel1!.email == null ||
                                    userModel1!.email!.isEmpty)
                                ? const SizedBox.shrink()
                                : CustomText(
                                    text: userModel1!.email!,
                                    colorText: Colors.white70,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                            const SizedBox(height: 32),
                          ],
                        );
                      } else if (connectState is InternetDisconnectedState) {
                        return const CustomText(
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
                ),
              ),
              // Bottom sheet card with improved rounded corners and spacing
              Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 28,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.kWhite,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowReusable(
                        onTap: () {},
                        leadingIcon: Icons.language,
                        leadingIconColor: AppColor.kPrimaryColor1,
                        leadingIconSize: 19,
                        title: CustomText(
                          text: S.of(context).language,
                          fontWeight: FontWeight.w600,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextButton(
                              onPressed: () {
                                BlocProvider.of<LocalizationCubit>(context)
                                    .appLanguage(
                                        LanguageEventEnums.englishLanguage);
                              },
                              text: 'English',
                              colorText: AppColor.kPrimaryColor1,
                            ),
                            const SizedBox(width: 4),
                            CustomTextButton(
                              onPressed: () {
                                BlocProvider.of<LocalizationCubit>(context)
                                    .appLanguage(
                                        LanguageEventEnums.arabicLanguage);
                              },
                              text: 'العربية',
                              colorText: AppColor.kPrimaryColor1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      RowReusable(
                        onTap: () async {
                          if (user != null) {
                            await ShowAlert.showErrorORWarningDialog(
                              isError: false,
                              context: context,
                              subtitle: 'Are you sure?',
                              fct: () async {
                                if (user != null) {
                                  await FirebaseAuth.instance.signOut();
                                  if (!mounted) return;
                                  pushNamedAndRemoveUntil(
                                    context,
                                    LoginOrSignUp.id,
                                  );
                                } else if (userGoogle == true) {
                                  GoogleSignIn googleSignIn = GoogleSignIn();
                                  await googleSignIn.disconnect();
                                  if (!mounted) return;
                                  pushNamedAndRemoveUntil(
                                    context,
                                    LoginOrSignUp.id,
                                  );
                                } else {
                                  return;
                                }
                              },
                            );
                          }
                        },
                        leadingIcon: Icons.logout,
                        leadingIconColor: AppColor.kPrimaryColor1,
                        leadingIconSize: 19,
                        title: CustomText(
                          text: S.of(context).logout,
                          fontWeight: FontWeight.w600,
                        ),
                        trailing: const CustomIcon(
                          icon: Icons.arrow_forward_ios,
                          color: AppColor.kText2,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RowReusable(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationView()),
                          );
                        },
                        leadingIcon: Icons.notifications,
                        leadingIconColor: AppColor.kPrimaryColor1,
                        leadingIconSize: 19,
                        title: const CustomText(
                          text: "Notification",
                          fontWeight: FontWeight.w600,
                        ),
                        trailing: const CustomIcon(
                          icon: Icons.arrow_forward_ios,
                          color: AppColor.kText2,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.kPrimaryColor1),
          );
        }
      },
    );
  }
}
