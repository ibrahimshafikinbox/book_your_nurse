import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

bool isLoginGoogle = false;
bool isLogin = false;
//String tokenEmail = FirebaseAuth.instance.;

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> signOutAll() async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.disconnect();
  await FirebaseAuth.instance.signOut();
}

PhoneNumber? phoneForgotPass;
Country? countryForgotPass;

String enteredPin = '';
bool isPinVisible = false;
