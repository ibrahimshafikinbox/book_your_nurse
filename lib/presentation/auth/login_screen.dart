import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/const/auth_const.dart';
import 'package:medical_app/const/navigations.dart';
import 'package:medical_app/const/shared_preferences.dart';

import 'package:medical_app/presentation/auth/sign_up_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
import '../../app/style/custom_row_button.dart';
import '../../cubits/connection/connection_state.dart';
import '../Bottom/bottom.dart';
import '../Bottom/bottom_nav_docotor.dart';
import 'auth_cubit/auth_cubit.dart';
import 'auth_cubit/auth_states.dart';
import 'forgot_password.dart';

GlobalKey<FormState> formFieldLogin = GlobalKey();
final emailLoginController = TextEditingController();
final passwordLoginController = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});
  static String id = 'Login screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String usertype = "user"; // <-- Move here!

  Widget build(BuildContext context) {
    bool isLoading = false;
    AuthCubit cubit = BlocProvider.of<AuthCubit>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginLoading) {
          // Center(
          //   child: CircularProgressIndicator(
          //     color: AppColor.kPrimaryColor1,),
          // );
          isLoading = true;
        } else if (state is LoginSuccess&&usertype == 'user' ) {
          // Save userType to sharedPreferences
          sharedPreferences?.setString('userType', 'user');
          showDialog(
            context: context,
            builder: (context) {
              return ShowAlertDialog(
                onTap: () {

                    Navigator.pushReplacementNamed(context, Bottombar.id);

                },
                text1: S.of(context).welcome_back,
                text2: S.of(context).once_again,
                heightButton: height / 12,
                textButton: S.of(context).go_to_home,
                widthButton: width / 2,
                widget: CustomIcon(
                  icon: Icons.done,
                  color: AppColor.kPrimaryColor1,
                  size: width / 5,
                ),
              );
            },
          );
          isLoading = false;
        }
        else if (state is LoginSuccess&&usertype == 'nurse' ) {
          // Save userType to sharedPreferences
          sharedPreferences?.setString('userType', 'nurse');
          showDialog(
            context: context,
            builder: (context) {
              return ShowAlertDialog(
                onTap: () {

                    Navigator.pushReplacementNamed(context, BottomNavDocotor.id);






                },
                text1: S.of(context).welcome_back,
                text2: S.of(context).once_again,
                heightButton: height / 12,
                textButton: S.of(context).go_to_home,
                widthButton: width / 2,
                widget: CustomIcon(
                  icon: Icons.done,
                  color: AppColor.kPrimaryColor1,
                  size: width / 5,
                ),
              );
            },
          );
          isLoading = false;
        }

        else if (state is LoginFailedState) {
          isLoading = false;
          showDialog(
              context: context,
              builder: (context) {
                return ShowAlertDialog(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text1:
                      S.of(context).something_wrong_happen_please_Login_again,
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
        } else if (state is GoogleLoginSuccess) {
          // Save userType to sharedPreferences for Google login
          sharedPreferences?.setString('userType', usertype);
          if (usertype == 'user') {
            Navigator.pushReplacementNamed(context, Bottombar.id);
          } else {
            Navigator.pushReplacementNamed(context, BottomNavDocotor.id);
          }

        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          color: AppColor.kPrimaryColor1,
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
                text: S.of(context).login,
                fontSize: width / 18,
                fontWeight: FontWeight.w700,
                colorText: AppColor.kText1,
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: height / 20,
                    right: width / 15,
                    left: width / 15,
                  ),
                  child: Form(
                    key: formFieldLogin,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: S.of(context).enter_email,
                          controller: emailLoginController,
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
                          validate: (email) {
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
                          controller: passwordLoginController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.isObscuredLogin,
                          prefixIcon: CustomIconButton(
                            icon: const Icon(Icons.lock_outline_rounded),
                            padding: EdgeInsets.only(
                              left: width / 23,
                              right: width / 23,
                            ),
                            onPressed: () {},
                          ),
                          suffixIcon: cubit.isObscuredLogin
                              ? CustomIconButton(
                                  icon: const Icon(Icons.visibility_off_outlined),
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .obscuredLogin();
                                  },
                                )
                              : CustomIconButton(
                                  icon: const Icon(Icons.visibility_outlined),
                                  color: AppColor.kPrimaryColor1,
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .obscuredLogin();
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
                          height: height / 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                pushNamed(context, ForgotPasswordScreen.id);
                              },
                              child: CustomText(
                                text: S.of(context).forgot_password,
                                colorText: AppColor.kPrimaryColor1,
                                fontSize: width / 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 18,
                        ),
                        BlocBuilder<InternetBloc, InternetState>(
                          builder: (context, state) {
                            if (state is InternetConnectedState) {
                              return CustomButton(
                                onTap: () {
                                  if (formFieldLogin.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context).loginUser(
                                      email: emailLoginController.text,
                                      password: passwordLoginController.text,
                                    );
                                  }
                                },
                                height: height / 12.5,
                                width: width / 1,
                                text: S.of(context).login,
                                color: AppColor.kPrimaryColor1,
                                borderRadius: BorderRadius.circular(32),
                                colorText: Colors.white,
                                fontSize: width / 20.5,
                                fontWeight: FontWeight.w600,
                              );
                            } else if (state is InternetDisconnectedState) {
                              return CustomText(
                                text: "Internet Not Connected",
                                colorText: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                        SizedBox(
                          height: height / 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: S.of(context).do_not_have_an_account,
                              colorText: AppColor.kText2,
                              fontSize: width / 24,
                              fontWeight: FontWeight.w400,
                            ),
                            GestureDetector(
                              onTap: () {
                                pushNamed(context, SignUp.id);
                              },
                              child: CustomText(
                                text: S.of(context).sign_up,
                                colorText: AppColor.kPrimaryColor1,
                                fontSize: width / 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: height / 27,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       height: width / 350,
                        //       width: width / 2.8,
                        //       decoration: const BoxDecoration(
                        //         color: AppColor.kText3,
                        //       ),
                        //     ),
                        //     CustomText(
                        //       text: '  OR  ',
                        //       colorText: AppColor.kText3,
                        //       fontSize: width / 23,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //     Container(
                        //       height: width / 350,
                        //       width: width / 2.8,
                        //       decoration: const BoxDecoration(
                        //         color: AppColor.kText3,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: height / 28,
                        // ),
                        // CustomRowButton(
                        //   onTap: () {
                        //     cubit.signInWithGoogle(context: context);
                        //   },
                        //   height: height / 12,
                        //   width: width / 1,
                        //   borderRadius: BorderRadius.circular(32),
                        //   border: Border.all(
                        //     color: AppColor.kText3,
                        //   ),
                        //   pathImage: 'Image/google.png',
                        //   heightImage: height / 28,
                        //   widthImage: width / 17,
                        //   text: 'Sign in with Google',
                        //   color: AppColor.kWhite,
                        //   colorText: AppColor.kText1,
                        //   fontSize: width / 21.5,
                        //   fontWeight: FontWeight.w600,
                        // ),
                        // SizedBox(
                        //    height: 16.h,
                        //  ),
                        //  CustomRowButton(
                        //    height: 56.h,
                        //    width: 327.w,
                        //    borderRadius: BorderRadius.circular(32.sp),
                        //    border: Border.all(
                        //      color: AppColor.kText3,
                        //    ),
                        //    pathImage: 'Image/apple.png',
                        //    heightImage: 20.h,
                        //    widthImage: 16.84.w,
                        //    text: 'Sign in with Apple',
                        //    color: AppColor.kWhite,
                        //    colorText: AppColor.kText1,
                        //    fontSize: 16.sp,
                        //    fontWeight: FontWeight.w600,
                        //  ),
                        //  SizedBox(
                        //    height: height / 35,
                        //  ),
                        //  CustomRowButton(
                        //    onTap: () {
                        //      cubit.signInWithFacebook().then((value) {
                        //        isLoginFacebook = true;
                        //        pushNamed(
                        //          context,
                        //          HomeScreen.id,
                        //        );
                        //      });
                        //    },
                        //    height: height / 12,
                        //    width: width / 1,
                        //    borderRadius: BorderRadius.circular(32),
                        //    border: Border.all(
                        //      color: AppColor.kText3,
                        //    ),
                        //    pathImage: 'Image/facebook.png',
                        //    heightImage: height / 28,
                        //    widthImage: width / 17,
                        //    text: 'Sign in with Facebook',
                        //    textAlign: TextAlign.center,
                        //    color: AppColor.kWhite,
                        //    colorText: AppColor.kText1,
                        //    fontSize: width / 21.5,
                        //    fontWeight: FontWeight.w600,
                        //  ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
