import 'package:bloc/bloc.dart';
import 'package:medical_app/const/shared_preferences.dart';
import 'package:medical_app/presentation/localization/model/localization.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());
  appLanguage(LanguageEventEnums eventType)
  {
    switch(eventType){
      case LanguageEventEnums.initialLanguage:
        if(sharedPreferences!.getString('language') != null){
          if(sharedPreferences!.getString('language') == 'ar'){
            emit(ChangeLanguage(languageCode: 'ar'));
          } else {
            emit(ChangeLanguage(languageCode: 'en'));
          }
        }
        break;
      case LanguageEventEnums.arabicLanguage:
        sharedPreferences!.setString('language', 'ar');
        emit(ChangeLanguage(languageCode: 'ar'));
        break;
      case LanguageEventEnums.englishLanguage:
        sharedPreferences!.setString('language', 'en');
        emit(ChangeLanguage(languageCode: 'en'));
        break;
        default:
    }
  }

}
