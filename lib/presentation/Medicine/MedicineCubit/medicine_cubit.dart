import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical_app/presentation/Medicine/model/activeingerdints.dart';

import '../model/Drugs.dart';

part 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit() : super(MedicineInitial());
  List<Drug> drugs = [];
  List<Drug> drugDetails = [];
  List<ActiveIngredients> activeIngredintDetails = [];
  List<ActiveIngredients> activeIngredintDetail = [];

  final ValueNotifier<bool> isShowingSpecifications = ValueNotifier(true);

  fetchMedicineData() async {
    try {
      drugs.clear();
      emit(MedicineLoading());

      // Fetch data from Firestore
      CollectionReference drugsCollection =
          FirebaseFirestore.instance.collection("Drugs");
      QuerySnapshot drugData =
          await drugsCollection.orderBy("productname", descending: true).get();

      for (var element in drugData.docs) {
        drugs.add(Drug.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(MedicineSuccessful());
    } catch (e) {
      emit(MedicineError(error: "Failed to load data: $e"));
    }
  }

  fetchMedicineDetails(String name, String photo) async {
    try {
      drugDetails.clear();
      emit(MedicineLoading());

      // Fetch data from Firestore
      CollectionReference drugsCollection =
          FirebaseFirestore.instance.collection("Drugs");
      Query query = drugsCollection
          .where("productname", isEqualTo: name)
          .where("Photo", isEqualTo: photo);
      QuerySnapshot drugDetailsData = await query.get();

      for (var element in drugDetailsData.docs) {
        drugDetails.add(Drug.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(MedicineSuccessful());
    } catch (e) {
      emit(MedicineError(error: "Failed to load data: $e"));
    }
  }

  Future<void> addToMyMedicine(String name, String photo) async {
    // Reference to the Drugs collection
    CollectionReference drugsCollection =
        FirebaseFirestore.instance.collection("Drugs");

    // Query to find the document where the name and photo match
    Query query = drugsCollection
        .where("productname", isEqualTo: name)
        .where("Photo", isEqualTo: photo);

    // Get the document that matches the query
    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      // Assuming there's a unique document matching the name and photo
      DocumentReference documentReference = querySnapshot.docs.first.reference;

      // Update the myDrugs array by adding the new item
      await documentReference.update({
        "myDrugs":
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });
      emit(MedicineAdd());

    }
  }

  Future<void> removeFromMyMedicine(String name, String photo) async {
    // Reference to the Drugs collection
    CollectionReference drugsCollection =
        FirebaseFirestore.instance.collection("Drugs");

    // Query to find the document where the name and photo match
    Query query = drugsCollection
        .where("productname", isEqualTo: name)
        .where("Photo", isEqualTo: photo);

    // Get the document that matches the query
    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      // Assuming there's a unique document matching the name and photo
      DocumentReference documentReference = querySnapshot.docs.first.reference;

      // Fetch the current myDrugs array to ensure the UID exists
      DocumentSnapshot documentSnapshot = await documentReference.get();
      List<dynamic> myDrugs = documentSnapshot['myDrugs'] ?? [];

      if (myDrugs.contains(FirebaseAuth.instance.currentUser!.uid)) {
        // Remove the UID from the myDrugs array
        await documentReference.update({
          "myDrugs":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        });
      }
    }
    emit(Medicineremove());

  }

  fetchActiveIngredintsDetails(String name) async {

    activeIngredintDetails.clear();
    emit(ActiveIngredintsloading());

    CollectionReference activeingredintsCollection =
    FirebaseFirestore.instance.collection("ActiveIngredints");
    Query query = activeingredintsCollection
        .where("Drug", isEqualTo:name);
    QuerySnapshot drugDetailsData = await query.get();

    for (var element in drugDetailsData.docs) {
      activeIngredintDetails.add(ActiveIngredients.fromJson(element.data() as Map<String, dynamic>));
    }

    emit(ActiveIngredintsSucceful());

  }

  fetchActiveIngredintDetail(String name) async {

    activeIngredintDetail.clear();
    emit(ActiveIngredintsloading());

    CollectionReference activeingredintsCollection =
    FirebaseFirestore.instance.collection("ActiveIngredints");
    Query query = activeingredintsCollection
        .where("Drug", isEqualTo:name);
    QuerySnapshot drugDetailsData = await query.get();

    for (var element in drugDetailsData.docs) {
      activeIngredintDetail.add(ActiveIngredients.fromJson(element.data() as Map<String, dynamic>));
    }

    emit(ActiveIngredintsSucceful());

  }


}
