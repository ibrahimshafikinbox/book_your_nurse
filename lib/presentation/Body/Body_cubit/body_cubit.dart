import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_app/presentation/Body/model/body_origin.dart';
import 'package:medical_app/presentation/Body/model/body_model.dart';


part 'body_state.dart';

class BodyCubit extends Cubit<BodyState> {
  BodyCubit() : super(BodyInitial());
  List<Body>? bodydata = [];
  List<BodyOrigin>? getdataname = [];
  List<BodyOrigin> nameOfDisease = [];
  List<BodyOrigin> nameOfDiseaseArabic = [];
  Set<String> selectedDiseases = {};

  Future<void> getDieseaseName(String disease) async {
    emit(BodyLoading());
    try {
      CollectionReference bodyRef =
      FirebaseFirestore.instance.collection("Disease");
      QuerySnapshot bodyData =
      await bodyRef.where("Disease", isEqualTo: disease).get();
      nameOfDisease = [];
      for (var element in bodyData.docs) {
        nameOfDisease
            .add(BodyOrigin.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(BodySuccess());
    } catch (e) {
      emit(BodyFailed(errorMessage: 'Error'));
    }
  }

  Future<void> getDieseaseNameArabic(String disease) async {
    emit(BodyLoading());
    try {
      CollectionReference bodyRef =
      FirebaseFirestore.instance.collection("Disease");
      QuerySnapshot bodyData =
      await bodyRef.where("DiseaseArabic", isEqualTo: disease).get();
      nameOfDiseaseArabic = [];
      for (var element in bodyData.docs) {
        nameOfDiseaseArabic
            .add(BodyOrigin.fromJson(element.data() as Map<String, dynamic>));
      }
      emit(BodyArabicSuccess());
    } catch (e) {
      emit(BodyFailed(errorMessage: 'Error'));
    }
  }

  Future<void> getData() async {
    emit(BodyLoading());
    try {
      CollectionReference bodyRef =
      FirebaseFirestore.instance.collection("Body");
      QuerySnapshot bodyData =
      await bodyRef.orderBy("id", descending: false).get();
      bodydata = [];
      for (var element in bodyData.docs) {
        bodydata!.add(Body.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(BodySuccess());
    } catch (e) {
      emit(BodyFailed(errorMessage: 'Error'));
    }
  }

  Future<void> getDataName(String part) async {
    emit(BodyLoading());
    try {
      CollectionReference bodyRef =
      FirebaseFirestore.instance.collection("Disease");
      QuerySnapshot bodyData =
      await bodyRef.where("Part", isEqualTo: part).get();
      getdataname = [];
      for (var element in bodyData.docs) {
        getdataname!
            .add(BodyOrigin.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(BodySuccess());
    } catch (e) {
      emit(BodyFailed(errorMessage: 'Error'));
    }
  }

  Future<void> getfilterenglish(List<String> symptoms, String name) async {
    emit(BodyLoading());
    try {
      CollectionReference bodyRef =
      FirebaseFirestore.instance.collection("Disease");
      QuerySnapshot bodyData =
      await bodyRef.where("Part", isEqualTo: name).get();
      nameOfDisease = [];
      for (var element in bodyData.docs) {
        nameOfDisease
            .add(BodyOrigin.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(BodySuccess());
    } catch (e) {
      emit(BodyFailed(errorMessage: 'Error'));
    }
  }

  Future<void> getfilterarabic(List<String> symptoms, String name) async {
    emit(BodyLoading());
    try {
      CollectionReference bodyRef =
      FirebaseFirestore.instance.collection("Disease");
      QuerySnapshot bodyData = await bodyRef
          .where("symptomsArabic", arrayContainsAny: symptoms)
          .where("Part", isEqualTo: name)
          .get();

      nameOfDiseaseArabic = [];
      for (var element in bodyData.docs) {
        nameOfDiseaseArabic
            .add(BodyOrigin.fromJson(element.data() as Map<String, dynamic>));
      }
      emit(BodySuccess());
    } catch (e) {
      emit(BodyFailed(errorMessage: 'Error'));
    }
  }

  void addSelectedDisease(String disease) {
    selectedDiseases.add(disease);
    emit(BodySuccess()); // You might want to create a specific state for this
  }


}


