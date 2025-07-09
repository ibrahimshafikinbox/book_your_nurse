import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:medical_app/const/shared_preferences.dart';
import 'package:medical_app/cubits/connection/connection_cubit.dart';
import 'package:medical_app/presentation/Booking/cubitt/booking_cubit.dart';
import 'package:medical_app/presentation/Bottom/bottom_nav_docotor.dart';
import 'package:medical_app/presentation/localization/model/localization.dart';
import 'package:medical_app/presentation/Body/Body_cubit/body_cubit.dart';
import 'package:medical_app/presentation/Body/List%20of%20Body.dart';
import 'package:medical_app/presentation/Bottom/bottom.dart';
import 'package:medical_app/presentation/Bottom/BottomAppbar/bottom_cubit.dart';
import 'package:medical_app/presentation/Medicine/MedicineCubit/medicine_cubit.dart';
import 'package:medical_app/presentation/auth/auth_cubit/auth_cubit.dart';
import 'package:medical_app/presentation/auth/forgot_password.dart';
import 'package:medical_app/presentation/auth/login_or_sign_up.dart';
import 'package:medical_app/presentation/auth/login_screen.dart';
import 'package:medical_app/presentation/auth/onboarding_screen.dart';
import 'package:medical_app/presentation/auth/sign_up_screen.dart';
import 'package:medical_app/presentation/auth/splash_screen.dart';
import 'package:medical_app/presentation/chat/chat_view.dart';
import 'package:medical_app/presentation/chat/messages_view.dart';
import 'package:medical_app/presentation/home/home.dart';
import 'package:medical_app/presentation/home/topdoctor.dart';
import 'package:medical_app/presentation/home/home_cubit/home_cubit.dart';
import 'package:medical_app/presentation/localization/localizationCubit/localization_cubit.dart';
import 'package:medical_app/presentation/profile_user/edite_profile.dart';
import 'package:medical_app/presentation/profile_user/profile_view.dart';
import 'package:medical_app/presentation/profile_user/update_to_doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_observer.dart';
import 'cubits/Searchcubit/search_cubit.dart';
import 'cubits/connection/connection_event.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 0));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = SimpleBlocObserver();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (width < 500) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomCubit()..screens),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => BookingCubit()),
        BlocProvider(
          create: (context) => InternetBloc()..add(InternetChecked()),
        ),
        BlocProvider(
          create: (context) => LocalizationCubit()
            ..appLanguage(LanguageEventEnums.initialLanguage),
        ),
        BlocProvider(create: (context) => HomeCubit()..data),
        BlocProvider(
          create: (context) => BodyCubit()
            ..bodydata
            ..getdataname,
        ),
        BlocProvider(create: (context) => SearchCubit()..searchList),
        BlocProvider(
          create: (context) => MedicineCubit()
            ..drugDetails
            ..drugs,
        ),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, langState) {
          Locale? locale;
          if (langState is ChangeLanguage) {
            locale = Locale(langState.languageCode!);
          }

          return MaterialApp(
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  // statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            // locale: locale,
            locale: locale ?? const Locale('en'),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (locale != null &&
                    locale.languageCode == supportedLocale.languageCode) {
                  return supportedLocale;
                }
              }
              return const Locale('en');
            },
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.id,
            routes: {
              SplashScreen.id: (context) => const SplashScreen(),
              Bottombar.id: (context) => Bottombar(),
              Onboarding.id: (context) => const Onboarding(),
              LoginOrSignUp.id: (context) => const LoginOrSignUp(),
              Login.id: (context) => const Login(),
              SignUp.id: (context) => const SignUp(),
              ForgotPasswordScreen.id: (context) =>
                  const ForgotPasswordScreen(),
              BottomNavDocotor.id: (context) =>
                  BottomNavDocotor(), // <-- ADD THIS
              HomeScreen.id: (context) => const HomeScreen(),
              Chat.id: (context) => const Chat(),
              MessagesView.id: (context) => const MessagesView(),
              ProfileView.id: (context) => const ProfileView(),
              EditeProfile.id: (context) => const EditeProfile(),
              UpdateToDoctor.id: (context) => const UpdateToDoctor(),
              TopDoctor.id: (context) => const TopDoctor(),
              ChooseTheBody.id: (context) => const ChooseTheBody(),
            },
          );
        },
      ),
    );
  }
}
