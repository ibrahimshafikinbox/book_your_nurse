// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Name must not empty`
  String get name_must_not_empty {
    return Intl.message(
      'Name must not empty',
      name: 'name_must_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Email must not empty`
  String get email_must_not_empty {
    return Intl.message(
      'Email must not empty',
      name: 'email_must_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get enter_a_valid_email {
    return Intl.message(
      'Enter a valid email',
      name: 'enter_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password must not empty`
  String get password_must_not_empty {
    return Intl.message(
      'Password must not empty',
      name: 'password_must_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Your Password Is Not Correct`
  String get enter_a_valid_password {
    return Intl.message(
      'Oops! Your Password Is Not Correct',
      name: 'enter_a_valid_password',
      desc: '',
      args: [],
    );
  }

  /// `phone must not empty`
  String get phone_must_not_empty {
    return Intl.message(
      'phone must not empty',
      name: 'phone_must_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get do_not_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'do_not_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Name`
  String get enter_name {
    return Intl.message(
      'Enter your Name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email`
  String get enter_email {
    return Intl.message(
      'Enter your Email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Password`
  String get enter_password {
    return Intl.message(
      'Enter your Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone`
  String get enter_phone {
    return Intl.message(
      'Enter your phone',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `You have account? `
  String get you_have_account {
    return Intl.message(
      'You have account? ',
      name: 'you_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Yeay! Welcome Back`
  String get welcome_back {
    return Intl.message(
      'Yeay! Welcome Back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Once again you login successfully into medical app`
  String get once_again {
    return Intl.message(
      'Once again you login successfully into medical app',
      name: 'once_again',
      desc: '',
      args: [],
    );
  }

  /// `Go to home`
  String get go_to_home {
    return Intl.message('Go to home', name: 'go_to_home', desc: '', args: []);
  }

  /// `You have already SignUp successfully into medidoc app`
  String get you_have_already_signup_successfully_into_medidoc_app {
    return Intl.message(
      'You have already SignUp successfully into medidoc app',
      name: 'you_have_already_signup_successfully_into_medidoc_app',
      desc: '',
      args: [],
    );
  }

  /// `Something wrong happen Please Login again`
  String get something_wrong_happen_please_Login_again {
    return Intl.message(
      'Something wrong happen Please Login again',
      name: 'something_wrong_happen_please_Login_again',
      desc: '',
      args: [],
    );
  }

  /// `Something wrong happen Please Sign up again`
  String get something_wrong_happen_please_sign_up_again {
    return Intl.message(
      'Something wrong happen Please Sign up again',
      name: 'something_wrong_happen_please_sign_up_again',
      desc: '',
      args: [],
    );
  }

  /// `Send code to Email`
  String get send_code_to_email {
    return Intl.message(
      'Send code to Email',
      name: 'send_code_to_email',
      desc: '',
      args: [],
    );
  }

  /// `Please Check your Email`
  String get please_check_your_Email {
    return Intl.message(
      'Please Check your Email',
      name: 'please_check_your_Email',
      desc: '',
      args: [],
    );
  }

  /// `Please Entre E-mail\nit like gmail,yahoo,Hotmail,etc...`
  String get please_entre {
    return Intl.message(
      'Please Entre E-mail\nit like gmail,yahoo,Hotmail,etc...',
      name: 'please_entre',
      desc: '',
      args: [],
    );
  }

  /// `we have send link to account Email`
  String get we_have_send_link_to_account_email {
    return Intl.message(
      'we have send link to account Email',
      name: 'we_have_send_link_to_account_email',
      desc: '',
      args: [],
    );
  }

  /// `Go to Login or Signup`
  String get go_to_login_or_sign_up {
    return Intl.message(
      'Go to Login or Signup',
      name: 'go_to_login_or_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Nurses`
  String get nurse {
    return Intl.message('Nurses', name: 'nurse', desc: '', args: []);
  }

  /// `profile`
  String get profile {
    return Intl.message('profile', name: 'profile', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Top Doctor`
  String get top_doctor {
    return Intl.message('Top Doctor', name: 'top_doctor', desc: '', args: []);
  }

  /// `Find\nDoctor`
  String get find_doctor {
    return Intl.message(
      'Find\nDoctor',
      name: 'find_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Check\nYourself`
  String get check_yourself {
    return Intl.message(
      'Check\nYourself',
      name: 'check_yourself',
      desc: '',
      args: [],
    );
  }

  /// `Early protection for\nyour family health`
  String get early_protection_for_your_family_health {
    return Intl.message(
      'Early protection for\nyour family health',
      name: 'early_protection_for_your_family_health',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get hi {
    return Intl.message('Hi', name: 'hi', desc: '', args: []);
  }

  /// `Show all`
  String get see_all {
    return Intl.message('Show all', name: 'see_all', desc: '', args: []);
  }

  /// `Find Doctors`
  String get find_doctors {
    return Intl.message(
      'Find Doctors',
      name: 'find_doctors',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Detail`
  String get doctor_detail {
    return Intl.message(
      'Doctor Detail',
      name: 'doctor_detail',
      desc: '',
      args: [],
    );
  }

  /// `Appointment`
  String get appointment {
    return Intl.message('Appointment', name: 'appointment', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Reason`
  String get reason {
    return Intl.message('Reason', name: 'reason', desc: '', args: []);
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Consultation`
  String get consultation {
    return Intl.message(
      'Consultation',
      name: 'consultation',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Payment Detail`
  String get payment_detail {
    return Intl.message(
      'Payment Detail',
      name: 'payment_detail',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message('Schedule', name: 'schedule', desc: '', args: []);
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message('Upcoming', name: 'upcoming', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Canceled`
  String get canceled {
    return Intl.message('Canceled', name: 'canceled', desc: '', args: []);
  }

  /// `Message`
  String get message {
    return Intl.message('Message', name: 'message', desc: '', args: []);
  }

  /// `Search your doctor`
  String get search_your_doctor {
    return Intl.message(
      'Search your doctor',
      name: 'search_your_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Find your desire \nfor your health solution`
  String get find_your_desire_health_solution {
    return Intl.message(
      'Find your desire \nfor your health solution',
      name: 'find_your_desire_health_solution',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chat {
    return Intl.message('Chats', name: 'chat', desc: '', args: []);
  }

  /// `Messaging`
  String get messaging {
    return Intl.message('Messaging', name: 'messaging', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Height`
  String get height {
    return Intl.message('Height', name: 'height', desc: '', args: []);
  }

  /// `Weight`
  String get weight {
    return Intl.message('Weight', name: 'weight', desc: '', args: []);
  }

  /// `Age`
  String get age {
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Logout from google`
  String get logoutGoogle {
    return Intl.message(
      'Logout from google',
      name: 'logoutGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Skip {
    return Intl.message('Skip', name: 'Skip', desc: '', args: []);
  }

  /// `Consult only with a doctor you trust`
  String get Consult_only_with_a_doctor_you_trust {
    return Intl.message(
      'Consult only with a doctor you trust',
      name: 'Consult_only_with_a_doctor_you_trust',
      desc: '',
      args: [],
    );
  }

  /// `Find a lot of specialist doctors in one place`
  String get Find_a_lot_of_specialist_doctors_in_one_place {
    return Intl.message(
      'Find a lot of specialist doctors in one place',
      name: 'Find_a_lot_of_specialist_doctors_in_one_place',
      desc: '',
      args: [],
    );
  }

  /// `Get connect our Online Consultation`
  String get Get_connect_our_Online_Consultation {
    return Intl.message(
      'Get connect our Online Consultation',
      name: 'Get_connect_our_Online_Consultation',
      desc: '',
      args: [],
    );
  }

  /// `AnatomicalLocation`
  String get AnatomicalLocation {
    return Intl.message(
      'AnatomicalLocation',
      name: 'AnatomicalLocation',
      desc: '',
      args: [],
    );
  }

  /// `Details About Diseases`
  String get DetailsAboutDiseases {
    return Intl.message(
      'Details About Diseases',
      name: 'DetailsAboutDiseases',
      desc: '',
      args: [],
    );
  }

  /// `Diagnosis`
  String get Diagnosis {
    return Intl.message('Diagnosis', name: 'Diagnosis', desc: '', args: []);
  }

  /// `First Aid`
  String get FirstAid {
    return Intl.message('First Aid', name: 'FirstAid', desc: '', args: []);
  }

  /// `Recommended Treatment`
  String get recommendedtreatment {
    return Intl.message(
      'Recommended Treatment',
      name: 'recommendedtreatment',
      desc: '',
      args: [],
    );
  }

  /// `when To Consult Professional`
  String get whenToConsultProfessional {
    return Intl.message(
      'when To Consult Professional',
      name: 'whenToConsultProfessional',
      desc: '',
      args: [],
    );
  }

  /// `Touching an organ to examine it.`
  String get Touchinganorgantoexamineit {
    return Intl.message(
      'Touching an organ to examine it.',
      name: 'Touchinganorgantoexamineit',
      desc: '',
      args: [],
    );
  }

  /// `Brain`
  String get Brain {
    return Intl.message('Brain', name: 'Brain', desc: '', args: []);
  }

  /// `symptoms`
  String get symptomsof {
    return Intl.message('symptoms', name: 'symptomsof', desc: '', args: []);
  }

  /// `Bones`
  String get Bones {
    return Intl.message('Bones', name: 'Bones', desc: '', args: []);
  }

  /// `Throat`
  String get Larynx {
    return Intl.message('Throat', name: 'Larynx', desc: '', args: []);
  }

  /// `Nose`
  String get Nose {
    return Intl.message('Nose', name: 'Nose', desc: '', args: []);
  }

  /// `Lungs`
  String get Lungs {
    return Intl.message('Lungs', name: 'Lungs', desc: '', args: []);
  }

  /// `Heart`
  String get Heart {
    return Intl.message('Heart', name: 'Heart', desc: '', args: []);
  }

  /// `Liver`
  String get Liver {
    return Intl.message('Liver', name: 'Liver', desc: '', args: []);
  }

  /// `Spleen`
  String get Spleen {
    return Intl.message('Spleen', name: 'Spleen', desc: '', args: []);
  }

  /// `Do you want to choose Bones?`
  String get DoyouwanttochooseBones {
    return Intl.message(
      'Do you want to choose Bones?',
      name: 'DoyouwanttochooseBones',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose theBrain?`
  String get DoyouwanttochoosetheBrain {
    return Intl.message(
      'Do you want to choose theBrain?',
      name: 'DoyouwanttochoosetheBrain',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose Larynx?`
  String get DoyouwanttochooseLarynx {
    return Intl.message(
      'Do you want to choose Larynx?',
      name: 'DoyouwanttochooseLarynx',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose the Nose?`
  String get DoyouwanttochoosetheNose {
    return Intl.message(
      'Do you want to choose the Nose?',
      name: 'DoyouwanttochoosetheNose',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose the Lungs?`
  String get DoyouwanttochoosetheLungs {
    return Intl.message(
      'Do you want to choose the Lungs?',
      name: 'DoyouwanttochoosetheLungs',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose the Heart?`
  String get DoyouwanttochoosetheHeart {
    return Intl.message(
      'Do you want to choose the Heart?',
      name: 'DoyouwanttochoosetheHeart',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose the Liver?`
  String get DoyouwanttochoosetheLiver {
    return Intl.message(
      'Do you want to choose the Liver?',
      name: 'DoyouwanttochoosetheLiver',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose the Spleen?`
  String get DoyouwanttochoosetheSpleen {
    return Intl.message(
      'Do you want to choose the Spleen?',
      name: 'DoyouwanttochoosetheSpleen',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose the Stomach?`
  String get DoyouwanttochoosetheStomach {
    return Intl.message(
      'Do you want to choose the Stomach?',
      name: 'DoyouwanttochoosetheStomach',
      desc: '',
      args: [],
    );
  }

  /// `Stomach`
  String get Stomach {
    return Intl.message('Stomach', name: 'Stomach', desc: '', args: []);
  }

  /// `Do you want to choose the Large and small intestine?`
  String get DoyouwanttochoosetheLargeandsmallintestine {
    return Intl.message(
      'Do you want to choose the Large and small intestine?',
      name: 'DoyouwanttochoosetheLargeandsmallintestine',
      desc: '',
      args: [],
    );
  }

  /// `Small and large intestine`
  String get Smallandlargeintestine {
    return Intl.message(
      'Small and large intestine',
      name: 'Smallandlargeintestine',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get Choose {
    return Intl.message('Choose', name: 'Choose', desc: '', args: []);
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message('Cancel', name: 'Cancel', desc: '', args: []);
  }

  /// `Do you want to choose eyes?`
  String get Doyouwanttochooseeyes {
    return Intl.message(
      'Do you want to choose eyes?',
      name: 'Doyouwanttochooseeyes',
      desc: '',
      args: [],
    );
  }

  /// `EYE`
  String get EYE {
    return Intl.message('EYE', name: 'EYE', desc: '', args: []);
  }

  /// `Do you want to choose Arteries and blood veins?`
  String get DoyouwanttochoosArteriesandbloodveins {
    return Intl.message(
      'Do you want to choose Arteries and blood veins?',
      name: 'DoyouwanttochoosArteriesandbloodveins',
      desc: '',
      args: [],
    );
  }

  /// `Arteries and blood veins`
  String get Arteriesandbloodveins {
    return Intl.message(
      'Arteries and blood veins',
      name: 'Arteriesandbloodveins',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose Kidney?`
  String get DoyouwanttochooseKidney {
    return Intl.message(
      'Do you want to choose Kidney?',
      name: 'DoyouwanttochooseKidney',
      desc: '',
      args: [],
    );
  }

  /// `Kidney`
  String get Kidney {
    return Intl.message('Kidney', name: 'Kidney', desc: '', args: []);
  }

  /// `Do you want to choose Male reproductive system?`
  String get DoyouwanttochooseMalereproductivesystem {
    return Intl.message(
      'Do you want to choose Male reproductive system?',
      name: 'DoyouwanttochooseMalereproductivesystem',
      desc: '',
      args: [],
    );
  }

  /// `Male Reproductive System`
  String get Malereproductivesystem {
    return Intl.message(
      'Male Reproductive System',
      name: 'Malereproductivesystem',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to choose Breast?`
  String get DoyouwanttochooseBreast {
    return Intl.message(
      'Do you want to choose Breast?',
      name: 'DoyouwanttochooseBreast',
      desc: '',
      args: [],
    );
  }

  /// `Breast`
  String get Breast {
    return Intl.message('Breast', name: 'Breast', desc: '', args: []);
  }

  /// `Do you want to choose Female reproductive system?`
  String get DoyouwanttochooseFemalereproductivesystem {
    return Intl.message(
      'Do you want to choose Female reproductive system?',
      name: 'DoyouwanttochooseFemalereproductivesystem',
      desc: '',
      args: [],
    );
  }

  /// `Female Reproductive System`
  String get Femalereproductivesystem {
    return Intl.message(
      'Female Reproductive System',
      name: 'Femalereproductivesystem',
      desc: '',
      args: [],
    );
  }

  /// `Self-Check`
  String get SelfCheck {
    return Intl.message('Self-Check', name: 'SelfCheck', desc: '', args: []);
  }

  /// `Search Results`
  String get SearchResults {
    return Intl.message(
      'Search Results',
      name: 'SearchResults',
      desc: '',
      args: [],
    );
  }

  /// `Lab\nTest`
  String get LabTest {
    return Intl.message('Lab\nTest', name: 'LabTest', desc: '', args: []);
  }

  /// `Lab Test`
  String get LabTest2 {
    return Intl.message('Lab Test', name: 'LabTest2', desc: '', args: []);
  }

  /// `Medcine\n `
  String get Medcine {
    return Intl.message('Medcine\n ', name: 'Medcine', desc: '', args: []);
  }

  /// `Next`
  String get Next {
    return Intl.message('Next', name: 'Next', desc: '', args: []);
  }

  /// `Disease`
  String get Disease {
    return Intl.message('Disease', name: 'Disease', desc: '', args: []);
  }

  /// `There is no disease with these symptoms`
  String get Thelistisempty {
    return Intl.message(
      'There is no disease with these symptoms',
      name: 'Thelistisempty',
      desc: '',
      args: [],
    );
  }

  /// `Causes`
  String get Causes {
    return Intl.message('Causes', name: 'Causes', desc: '', args: []);
  }

  /// `Preventive Measures`
  String get PreventiveMeasures {
    return Intl.message(
      'Preventive Measures',
      name: 'PreventiveMeasures',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get Description {
    return Intl.message('Description', name: 'Description', desc: '', args: []);
  }

  /// `Search drugs, category...`
  String get Searchdrugs {
    return Intl.message(
      'Search drugs, category...',
      name: 'Searchdrugs',
      desc: '',
      args: [],
    );
  }

  /// `Medcine`
  String get Medcine1 {
    return Intl.message('Medcine', name: 'Medcine1', desc: '', args: []);
  }

  /// `Product ID`
  String get ProductID {
    return Intl.message('Product ID', name: 'ProductID', desc: '', args: []);
  }

  /// `Company`
  String get Company {
    return Intl.message('Company', name: 'Company', desc: '', args: []);
  }

  /// `Dosage form`
  String get Dosageform {
    return Intl.message('Dosage form', name: 'Dosageform', desc: '', args: []);
  }

  /// `Active Ingredients`
  String get ActiveIngredients {
    return Intl.message(
      'Active Ingredients',
      name: 'ActiveIngredients',
      desc: '',
      args: [],
    );
  }

  /// `Parcode`
  String get Parcode {
    return Intl.message('Parcode', name: 'Parcode', desc: '', args: []);
  }

  /// `Is Avaliable In SaudiArabia`
  String get IsAvaliableInSaudiArabia {
    return Intl.message(
      'Is Avaliable In SaudiArabia',
      name: 'IsAvaliableInSaudiArabia',
      desc: '',
      args: [],
    );
  }

  /// `Is Avaliable In Egypt`
  String get IsAvaliableInEgypt {
    return Intl.message(
      'Is Avaliable In Egypt',
      name: 'IsAvaliableInEgypt',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get No {
    return Intl.message('No', name: 'No', desc: '', args: []);
  }

  /// `Categories`
  String get Categories {
    return Intl.message('Categories', name: 'Categories', desc: '', args: []);
  }

  /// `Find a doctor`
  String get Searchdoctor {
    return Intl.message(
      'Find a doctor',
      name: 'Searchdoctor',
      desc: '',
      args: [],
    );
  }

  /// `See other Categories`
  String get SeeotherCategories {
    return Intl.message(
      'See other Categories',
      name: 'SeeotherCategories',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get Showmore {
    return Intl.message('Show more', name: 'Showmore', desc: '', args: []);
  }

  /// `Show less`
  String get Showless {
    return Intl.message('Show less', name: 'Showless', desc: '', args: []);
  }

  /// `Product Consistency`
  String get Productconsistency {
    return Intl.message(
      'Product Consistency',
      name: 'Productconsistency',
      desc: '',
      args: [],
    );
  }

  /// `Specifications`
  String get Specifications {
    return Intl.message(
      'Specifications',
      name: 'Specifications',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get Details {
    return Intl.message('Details', name: 'Details', desc: '', args: []);
  }

  /// `Product Type`
  String get producttype {
    return Intl.message(
      'Product Type',
      name: 'producttype',
      desc: '',
      args: [],
    );
  }

  /// `Route of Administration`
  String get RouteofAdministration {
    return Intl.message(
      'Route of Administration',
      name: 'RouteofAdministration',
      desc: '',
      args: [],
    );
  }

  /// `Classification`
  String get Classification {
    return Intl.message(
      'Classification',
      name: 'Classification',
      desc: '',
      args: [],
    );
  }

  /// `Price:`
  String get Price {
    return Intl.message('Price:', name: 'Price', desc: '', args: []);
  }

  /// `Egp`
  String get Egp {
    return Intl.message('Egp', name: 'Egp', desc: '', args: []);
  }

  /// `Possible side effects:`
  String get Possiblesideeffects {
    return Intl.message(
      'Possible side effects:',
      name: 'Possiblesideeffects',
      desc: '',
      args: [],
    );
  }

  /// `Possible side effects`
  String get Possiblesideeffects2 {
    return Intl.message(
      'Possible side effects',
      name: 'Possiblesideeffects2',
      desc: '',
      args: [],
    );
  }

  /// `Class`
  String get Class {
    return Intl.message('Class', name: 'Class', desc: '', args: []);
  }

  /// `Name`
  String get Name1 {
    return Intl.message('Name', name: 'Name1', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
