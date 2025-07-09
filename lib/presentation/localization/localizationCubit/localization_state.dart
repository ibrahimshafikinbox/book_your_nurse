part of 'localization_cubit.dart';

abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class ChangeLanguage extends LocalizationState {
  final String? languageCode;

  ChangeLanguage({this.languageCode});
}
