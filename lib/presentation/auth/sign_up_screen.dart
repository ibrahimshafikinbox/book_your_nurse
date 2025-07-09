import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/const/navigations.dart';
import 'package:medical_app/const/shared_preferences.dart';

import '../../../const/colors.dart';
import '../../../cubits/connection/connection_cubit.dart';
import '../../../generated/l10n.dart';
import '../../app/style/Custom_appbar.dart';
import '../../app/style/custom_button.dart';
import '../../app/style/custom_drop_down_menu.dart';
import '../../app/style/custom_icon.dart';
import '../../app/style/custom_icon_button.dart';
import '../../app/style/custom_text.dart';
import '../../app/style/custom_text_form_field.dart';
import '../../app/style/show_alert_dialog.dart';

import '../../cubits/connection/connection_state.dart';
import '../Bottom/bottom.dart';
import '../Bottom/bottom_nav_docotor.dart';
import 'auth_cubit/auth_cubit.dart';
import 'auth_cubit/auth_states.dart';

GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
final nameSignUpController = TextEditingController();
final emailSignUpController = TextEditingController();
final passwordSignUpController = TextEditingController();
final phoneSignUpController = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static String id = 'signup screen';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  var usertype="user";

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          elevation: 0,
          toolbarHeight: height / 14,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: CustomIconButton(
            onPressed: () {
              navigatePop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.kText1,
            ),
          ),
          title: CustomText(
            text: S.of(context).sign_up,
            fontSize: width / 18,
            fontWeight: FontWeight.w700,
            colorText: AppColor.kText1,
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              // Save userType to sharedPreferences
              sharedPreferences?.setString('userType', usertype);
              showDialog(
                  context: context,
                  builder: (context) {
                    return ShowAlertDialog(
                      onTap: () {
                        if (usertype == 'user') {
                          Navigator.pushReplacementNamed(context, Bottombar.id);
                        } else {
                          Navigator.pushReplacementNamed(context, BottomNavDocotor.id);
                        }
                      },
                      text1: S.of(context).welcome_back,
                      text2: S
                          .of(context)
                          .you_have_already_signup_successfully_into_medidoc_app,
                      heightButton: height / 12,
                      textButton: S.of(context).go_to_home,
                      widthButton: width / 2,
                      widget: CustomIcon(
                        icon: Icons.done,
                        color: AppColor.kPrimaryColor1,
                        size: width / 5,
                      ),
                    );
                  });
            } else if (state is SignUpFailed) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ShowAlertDialog(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text1: S
                          .of(context)
                          .something_wrong_happen_please_sign_up_again,
                      text2: state.errorMessage,
                      heightButton: height / 12,
                      textButton: S.of(context).close,
                      widthButton: width / 2,
                      widget: CustomIcon(
                        icon: Icons.close,
                        color: AppColor.kPrimaryColor1,
                        size: width / 5,
                      ),
                    );
                  });
            }
          },
          builder: (context, state) {
            AuthCubit cubit = BlocProvider.of<AuthCubit>(context);
            if (state is SignUpLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: height / 20,
                    right: width / 15,
                    left: width / 15,
                  ),
                  child: Form(
                    key: formKeySignUp,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          onChanged: (data) {
                            cubit.name = data;
                          },
                          hintText: S.of(context).enter_name,
                          controller: nameSignUpController,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          prefixIcon: CustomIconButton(
                            icon: const Icon(Icons.person_outline),
                            padding: EdgeInsets.only(
                              left: width / 23,
                              right: width / 23,
                            ),
                            onPressed: () {},
                          ),
                          validate: (String? name) {
                            if (name!.isNotEmpty) {
                              return null;
                            } else {
                              return S.of(context).name_must_not_empty;
                            }
                          },
                        ),
                        SizedBox(
                          height: height / 46,
                        ),
                        CustomTextFormField(
                          onChanged: (data) {},
                          hintText: S.of(context).enter_email,
                          controller: emailSignUpController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          prefixIcon: CustomIconButton(
                            icon: const Icon(Icons.email_outlined),
                            padding: EdgeInsets.only(
                              left: width / 23,
                              right: width / 23,
                            ),
                            onPressed: () {},
                          ),
                          validate: (String? email) {
                            if (email!.isEmpty) {
                              return S.of(context).email_must_not_empty;
                            } else if (!EmailValidator.validate(email)) {
                              return S.of(context).enter_a_valid_email;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: height / 46,
                        ),
                        CustomTextFormField(
                          hintText: S.of(context).enter_password,
                          controller: passwordSignUpController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.isObscuredSignup,
                          prefixIcon: CustomIconButton(
                            icon: const Icon(Icons.lock_outline_rounded),
                            padding: EdgeInsets.only(
                              left: width / 23,
                              right: width / 23,
                            ),
                            onPressed: () {},
                          ),
                          suffixIcon: cubit.isObscuredSignup
                              ? CustomIconButton(
                                  icon: const Icon(Icons.visibility_off_outlined),
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .obscuredSignUp();
                                  },
                                )
                              : CustomIconButton(
                                  icon: const Icon(Icons.visibility_outlined),
                                  color: AppColor.kPrimaryColor1,
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .obscuredSignUp();
                                  },
                                ),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).password_must_not_empty;
                            } else if (value.length < 7) {
                              return S.of(context).enter_a_valid_password;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: height / 46,
                        ),
                        CustomTextFormField(
                          onChanged: (data) {},
                          hintText: S.of(context).enter_phone,
                          controller: phoneSignUpController,
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          prefixIcon: CustomIconButton(
                            icon: const Icon(Icons.phone_outlined),
                            padding: EdgeInsets.only(
                              left: width / 23,
                              right: width / 23,
                            ),
                            onPressed: () {},
                          ),
                          validate: (String? phone) {
                            if (phone!.isEmpty) {
                              return S.of(context).phone_must_not_empty;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height / 46,
                        ),
                        CustomDropDownFormField<String>(
                          items: ['user', 'nurse'].map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          )).toList(),
                          hintText: 'user',
                          value: usertype,
                          onChanged: (val) {
                            setState(() {
                              usertype = val!;
                              print(usertype);
                            });
                          },
                        ),
                        SizedBox(
                          height: height / 15,
                        ),
                        BlocBuilder<InternetBloc, InternetState>(
                          builder: (context, stateConnect) {
                            if (stateConnect is InternetConnectedState) {
                              return CustomButton(
                                onTap: () async {
                                  if (formKeySignUp.currentState!.validate()) {
                                    cubit.registerUser(
                                      email: emailSignUpController.text,
                                      password: passwordSignUpController.text,
                                      name: nameSignUpController.text,
                                      phone: phoneSignUpController.text,
                                      userType: usertype,
                                      about: 'Hello, I am using app',
                                    ).then((_) {
                                      if (nameSignUpController.text.isNotEmpty) {
                                        FirebaseAuth.instance.currentUser!
                                            .updateDisplayName(nameSignUpController.text);
                                      }
                                    }).then((_) {
                                      if (phoneSignUpController.text.isNotEmpty) {
                                        FirebaseFirestore.instance
                                            .collection(kUsersCollections)
                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                            .update({kPhone: phoneSignUpController.text});
                                      }
                                    }).then((_) {
                                      nameSignUpController.clear();
                                      emailSignUpController.clear();
                                      passwordSignUpController.clear();
                                      phoneSignUpController.clear();
                                    });
                                  }
                                },
                                height: height / 12.5,
                                width: width,
                                borderRadius: BorderRadius.circular(32),
                                text: S.of(context).sign_up,
                                color: AppColor.kPrimaryColor1,
                                colorText: AppColor.kWhite,
                                fontSize: width / 20.5,
                                fontWeight: FontWeight.w600,
                              );
                            } else if (stateConnect is InternetDisconnectedState) {
                              return CustomText(
                                text: "Internet Not Connected",
                                colorText: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              );
                            } else {
                              return const SizedBox(); // أو Placeholder في حالة Unknown
                            }
                          },
                        ),
                        SizedBox(
                          height: height / 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: S.of(context).you_have_account,
                              colorText: AppColor.kText2,
                              fontSize: width / 24,
                              fontWeight: FontWeight.w400,
                            ),
                            GestureDetector(
                              onTap: () {
                                navigatePop(context);
                              },
                              child: CustomText(
                                text: S.of(context).login,
                                colorText: AppColor.kPrimaryColor1,
                                fontSize: width / 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
