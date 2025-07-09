import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:medical_app/const/chat_const.dart';
import '../../../const/auth_const.dart';
import '../../../const/navigations.dart';
import '../../../const/show_dialog.dart';
import '../../Bottom/bottom.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  //   login
  bool isObscuredLogin = true;

  void obscuredLogin() {
    emit(ChangeObscuredLogin());
    isObscuredLogin = !isObscuredLogin;
  }

  Future<void> loginUser({
      required String email,
      required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    }on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailedState(errorMessage: 'User not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailedState(errorMessage: 'Password is wrong'));
      }
    } catch (e) {
      emit(LoginFailedState(errorMessage: 'Something went wrong'));
    }
  }

  //  signUp
  String? name;
  String? email;
  PhoneNumber? phone;
  Country? country;
  String? pass;
  String? confirmPass;

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String userType,
    required String about,
  }) async {
    emit(SignUpLoading());
    try {
      // Save additional user information to Firestore
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUpSuccess());
      if(userType=="nurse"){
        await FirebaseFirestore.instance
            .collection('nurse')
            .doc(userCredential.user!.uid)
            .set({
          "id":userCredential.user!.uid,
          'name_en': name,
          "name_ar":name,
          'phone': phone,
          'email': email,
          "city_ar":"القاهرة",
          "city_en":"Cairo",
          "services":[],
          kImage: '',
          'userType': userType,
          'email':email,
          kAbout : about,
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'phone': phone,
          'email': email,
          kImage: '',
          'userType': userType,
          kAbout : about,
        });

      }
      else{
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'phone': phone,
          'email': email,
          kImage: '',
          'userType': userType,
          kAbout : about,
        });

      }

    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(SignUpFailed(
            errorMessage: 'Weak Password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(SignUpFailed(
            errorMessage: 'Email Already Exist'));
      }
    } catch (e) {
      emit(SignUpFailed(
          errorMessage: 'something went wrong please try again'));
    }
  }

  bool isObscuredSignup = true;

  void obscuredSignUp() {
    emit(ChangeObscuredSignUp());
    isObscuredSignup = !isObscuredSignup;
  }

  //   forgot password
  final formFieldForgotPass = GlobalKey<FormState>();
  final phoneForgotPassController = TextEditingController();

  Future resetPassword(String emailReset) async{
    emit(ResetPasswordLoading());
    try{
      return await FirebaseAuth.instance.
      sendPasswordResetEmail(email: emailReset).then((value) {
        emit(ResetPasswordSuccess());
      });
    }
    catch(e){
      emit(ResetPasswordFailed());
    }
  }

  //   otp
  String? otpCode;

  //    collection user in firebase
  //UserModel? userModel;

  // dynamic showAwesomeDialog(BuildContext context, DialogType dialogType, String textTitle, String textDesc) {
  //   return AwesomeDialog(
  //     context: context,
  //     dialogType: dialogType,
  //     animType: AnimType.rightSlide,
  //     title: textTitle,
  //     desc: textDesc,
  //   ).show();
  // }
  // Future<void> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   print('OMAR ERR');
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   emit(GoogleLoginSuccess());
  //
  //   // Add the return statement
  // }

  //  google login
  Future<void> signInWithGoogle({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if(googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final authResults = await FirebaseAuth.instance.signInWithCredential(credential);
        if(authResults.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance
              .collection(kUsersCollections).doc(
              authResults.user!.uid).set({
            kId : authResults.user!.uid,
            kName : authResults.user!.displayName,
            kImage : authResults.user!.photoURL,
            kEmail : authResults.user!.email,
            kCreateAt : Timestamp.now(),
            kAbout: "Hello i'm using app",
          });
        }
        pushReplacementNamed(
          context, Bottombar.id,
        );
        isLoginGoogle = true;
      }
      if(!context.mounted) return;
    } on FirebaseException catch(e) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ShowAlert.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occured ${e.message}",
          fct: () {},
        );
      });
    } catch(e) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ShowAlert.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occured $e",
          fct: () {},
        );
      });
    }
  }
  // Future<void> signInWithGoogle() async {
  //   emit(GoogleLoginLoading());
  //
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser =
  //     await GoogleSignIn().signIn();
  //
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser!.authentication;
  //
  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     // Once signed in, return the UserCredential
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential);
  //     emit(GoogleLoginSuccess());
  //
  //     // Check if the userCredential is not null, indicating successful login
  //     if (userCredential.user != null) {
  //       emit(GoogleLoginSuccess());
  //     } else {
  //       // If the userCredential is null, emit a failure state
  //       emit(GoogleLoginFailed("User not authenticated"));
  //     }
  //     String emailGoogle = userCredential.user!.email!;
  //     String nameGoogle = userCredential.user!.displayName!;
  //     String phoneGoogle = userCredential.user!.phoneNumber!;
  //     String photoGoogle = userCredential.user!.photoURL!;
  //
  //     print('my e ${emailGoogle.toString()}');
  //     print('my e ${nameGoogle.toString()}');
  //     print('my e ${phoneGoogle.toString()}');
  //
  //     await FirebaseFirestore.instance.collection(kUsersCollections)
  //         .doc(FirebaseAuth.instance.currentUser!.uid).set({
  //           kName: nameGoogle,
  //           kPhone: phoneGoogle,
  //           kEmail: emailGoogle,
  //           kImage: photoGoogle,
  //         },
  //       SetOptions(merge: true),
  //     );
  //   } catch (e) {
  //     // Emit failure state with error message
  //     print('OMAR ERR $e');
  //
  //     emit(GoogleLoginFailed(e.toString()));
  //   }
  // }

  void uploadUserData(UserCredential userData) {
    final database = FirebaseFirestore.instance;

    database.collection(kUsersCollections).doc(userData.user?.uid).set(
        {
          kName: userData.user?.displayName,
          kPhone: userData.user?.phoneNumber,
          kEmail: userData.user?.email,
        },
        SetOptions(merge: true),
       );
  }

  // facebook login

  //  another facebook login
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //  Chat
  TextEditingController msgController = TextEditingController();
  final scrollController = ScrollController();

  //  edite profile

  bool nameChanged = false;
  void editName() {
    emit(EditName());
    nameChanged = !nameChanged;
  }



// void showAwesomeDialog(BuildContext context, DialogType dialogType, String textTitle, String textDesc) {
//   AwesomeDialog(
//     context: context,
//     dialogType: dialogType,
//     animType: AnimType.rightSlide,
//     title: textTitle,
//     desc: textDesc,
//   ).show();
// }
}
