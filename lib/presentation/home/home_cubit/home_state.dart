part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class TopdoctorHomeloading extends HomeState {}

class TopdoctorHomeError extends HomeState {
  String error;
  TopdoctorHomeError({required this.error});
}
class TopdoctorHomeSuccefully extends HomeState {
  // final List<DocumentSnapshot> data;
  //
  // TopdoctorHomeSuccefully(this.data);
}
