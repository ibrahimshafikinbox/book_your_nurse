import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // لإحضار uid للمستخدم
import 'package:medical_app/presentation/home/model/Doctor.model.dart';

import '../model/nurse_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Nurse> data = [];

  Future<void> fetchHomeData() async {
    try {
      data.clear();
      emit(TopdoctorHomeloading());

      CollectionReference nurseCollection =
      FirebaseFirestore.instance.collection("nurse");

      QuerySnapshot nurseData = await nurseCollection.get();

      for (var element in nurseData.docs) {
        data.add(Nurse.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(TopdoctorHomeSuccefully());
    } catch (e) {
      emit(TopdoctorHomeError(error: "Failed to load data: $e"));
    }
  }

  List<Nurse> data2 = [];

  Future<void> fetchIamDoctorData() async {
    try {
      emit(TopdoctorHomeloading());

      final String uid = FirebaseAuth.instance.currentUser!.uid;

      if (uid.isEmpty) {
        emit(TopdoctorHomeError(error: "User not authenticated."));
        return;
      }

      DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection("nurse").doc(uid).get();

      if (doc.exists) {
        data2.add(Nurse.fromJson(doc.data() as Map<String, dynamic>));
        emit(TopdoctorHomeSuccefully());
      } else {
        emit(TopdoctorHomeError(error: "No data found for this user."));
      }
    } catch (e) {
      emit(TopdoctorHomeError(error: "Failed to load data: $e"));
    }
  }
  Future<void> updateNurseServices(Nurse nurse) async {
    emit(TopdoctorHomeloading());
    try {
      await FirebaseFirestore.instance
          .collection('nurse')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'services': nurse.services?.map((s) => s.toJson()).toList(),
      });
      emit(TopdoctorHomeSuccefully());
    } catch (e) {
      emit(TopdoctorHomeError(error: e.toString()));
    }
  }

}
