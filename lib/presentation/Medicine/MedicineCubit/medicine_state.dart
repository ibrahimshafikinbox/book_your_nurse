part of 'medicine_cubit.dart';

abstract class MedicineState {}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineSuccessful extends MedicineState {}
class MedicineAdd extends MedicineState {}
class Medicineremove extends MedicineState {}

class MedicineError extends MedicineState {
  final String error;
  MedicineError({required this.error});
}


class ActiveIngredintsloading extends MedicineState {}
class ActiveIngredintsSucceful extends MedicineState {}
class ActiveIngredintsError extends MedicineState {
  final String errorMessage;

  ActiveIngredintsError({required this.errorMessage});
}
