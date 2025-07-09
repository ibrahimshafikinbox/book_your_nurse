part of 'body_cubit.dart';

abstract  class BodyState {
}

class BodyInitial extends BodyState {}

class BodyLoading extends BodyState {}

class BodySuccess extends BodyState {}

class BodyArabicSuccess extends BodyState {}

class BodyFailed extends BodyState {
  final String errorMessage;
  BodyFailed({required this.errorMessage});
}


