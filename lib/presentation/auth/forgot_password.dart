import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../const/colors.dart';
import '../../../const/navigations.dart';
import '../../../cubits/connection/connection_cubit.dart';
import '../../../generated/l10n.dart';
import '../../app/style/Custom_appbar.dart';
import '../../app/style/custom_button.dart';
import '../../app/style/custom_icon.dart';
import '../../app/style/custom_icon_button.dart';
import '../../app/style/custom_text.dart';
import '../../app/style/custom_text_form_field.dart';
import '../../app/style/show_alert_dialog.dart';
import '../../cubits/connection/connection_event.dart';
import '../../cubits/connection/connection_state.dart';
import 'auth_cubit/auth_cubit.dart';
import 'auth_cubit/auth_states.dart';
import 'login_or_sign_up.dart';

GlobalKey<FormState> formReset = GlobalKey<FormState>();
TextEditingController emailReset = TextEditingController();

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static String id = 'forgotPassword screen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = BlocProvider.of<AuthCubit>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if(state is ResetPasswordLoading){
            const Center(
              child: CircularProgressIndicator(color: AppColor.kPrimaryColor1,),
            );
          }
          else if (state is ResetPasswordSuccess) {
            showDialog(
              context: context,
              builder: (context) {
                return ShowAlertDialog(
                  onTap: () {
                    pushNamedAndRemoveUntil(context, LoginOrSignUp.id);
                  },
                  text1: S.of(context).please_check_your_Email,
                  text2: S.of(context).we_have_send_link_to_account_email,
                  heightButton: height / 12,
                  textButton: S.of(context).go_to_login_or_sign_up,
                  widthButton: width / 2,
                  widget: CustomIcon(
                    icon: Icons.done,
                    color: AppColor.kPrimaryColor1,
                    size: width / 5,
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;

          return Scaffold(
            appBar: CustomAppBar(
              elevation: 0,
              toolbarHeight: height / 14,
              centerTitle: true,
              leading: CustomIconButton(
                onPressed: () {
                  navigatePop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.kText1,
                ),
              ),
            ),
            body: state is ResetPasswordLoading
                ? const CircularProgressIndicator(
                    color: AppColor.kPrimaryColor1,
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 15,
                        vertical: height / 20,
                      ),
                      child: Form(
                        key: formReset,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: S.of(context).forgot_password,
                              fontSize: width / 16,
                              fontWeight: FontWeight.w700,
                              colorText: AppColor.kText1,
                            ),
                            SizedBox(
                              height: width / 40,
                            ),
                            CustomText(
                              text: S.of(context).please_entre,
                              fontSize: width / 22,
                              fontWeight: FontWeight.w400,
                              colorText: AppColor.kText3,
                            ),
                            SizedBox(
                              height: height / 30,
                            ),
                            CustomTextFormField(
                              hintText: S.of(context).enter_email,
                              controller: emailReset,
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
                              validate: (String? name) {
                                if (name!.isNotEmpty) {
                                  return null;
                                } else {
                                  return S.of(context).name_must_not_empty;
                                }
                              },
                            ),
                            SizedBox(
                              height: height / 20,
                            ),
                            BlocBuilder<InternetBloc, InternetState>(
                              builder: (context, connectState) {
                                if (connectState is InternetConnectedState) {
                                  return CustomButton(
                                    onTap: () async {
                                      if (formReset.currentState!.validate()) {
                                        cubit.resetPassword(emailReset.text);
                                      }
                                    },
                                    height: height / 12.5,
                                    width: width / 1,
                                    text: S.of(context).send_code_to_email,
                                    color: AppColor.kPrimaryColor1,
                                    borderRadius: BorderRadius.circular(32),
                                    colorText: Colors.white,
                                    fontSize: width / 20.5,
                                    fontWeight: FontWeight.w600,
                                  );
                                } else if (connectState is InternetDisconnectedState) {
                                  return CustomText(
                                    text: "Internet Not Connected",
                                    colorText: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  );
                                } else {
                                  return const SizedBox(); // or a placeholder widget
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
