import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../presentation/Body/model/body_origin.dart';
import '../../presentation/Medicine/model/Drugs.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<BodyOrigin> searchList = [];
  List<Drug> searchList1 = [];
  List<Drug> pagination = [];
  DocumentSnapshot? lastDocument;
  bool isLoadingMore = false;

  Future<void> fetchMedicinePagination() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    try {
      emit(MedicineSearchLoading());

      // Fetch data from Firestore
      CollectionReference drugsCollection = FirebaseFirestore.instance.collection("Drugs");

      Query query = drugsCollection.orderBy("productname", descending: true).limit(30); // Adjust the limit as needed

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot drugData = await query.get();

      if (drugData.docs.isNotEmpty) {
        lastDocument = drugData.docs.last;
        pagination.addAll(drugData.docs.map((e) => Drug.fromJson(e.data() as Map<String, dynamic>)).toList());
        emit(MedicineSearchSuccessful());
      } else {
        // No more data to load
        emit(MedicineSearchSuccessful());
      }
    } catch (e) {
      emit(MedicineSearchError(error: "Failed to load data: $e"));
    }
    isLoadingMore = false;
  }

  searchCubitMedicine(String search) async {
    emit(MedicineSearchploading());
    searchList1.clear();

    CollectionReference medicineRef = FirebaseFirestore.instance.collection("Drugs");

    try {
      // Search in English product names
      QuerySnapshot medicineDataEn = await medicineRef
          .where("productname", isGreaterThanOrEqualTo: search)
          .where("productname", isLessThanOrEqualTo: '$search\uf8ff')
          .get();

      // Search in Arabic product names
      QuerySnapshot medicineDataAr = await medicineRef
          .where("productnamearabic", isGreaterThanOrEqualTo: search)
          .where("productnamearabic", isLessThanOrEqualTo: '$search\uf8ff')
          .get();

      // Add search results to searchList1
      for (var element in medicineDataEn.docs) {
        searchList1.add(Drug.fromJson(element.data() as Map<String, dynamic>));
      }
      for (var element in medicineDataAr.docs) {
        searchList1.add(Drug.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(MedicineSearchDataSuccessful(searchResults1: searchList1));
    } catch (e) {
      emit(MedicineSearchDataError(errorMessage: 'Error'));
    }
  }

  searchCubit(String search) async {
    emit(GetSearchploading());
    searchList.clear();  // Clear the list before starting a new search

    CollectionReference bodyRef = FirebaseFirestore.instance.collection("Disease");

    try {
      String searchLower = search.toLowerCase(); // Convert search string to lowercase

      // English search
      QuerySnapshot bodyDataEn = await bodyRef
          .orderBy("Disease")
          .startAt([search])
          .endAt(["$search\uf8ff"])
          .get();

      QuerySnapshot bodyDataEnLower = await bodyRef
          .orderBy("Disease")
          .startAt([searchLower])
          .endAt(["$searchLower\uf8ff"])
          .get();

      // Arabic search
      QuerySnapshot bodyDataAr = await bodyRef
          .orderBy("DiseaseArabic")
          .startAt([search])
          .endAt(["$search\uf8ff"])
          .get();

      // Add English search results to searchList
      for (var element in bodyDataEn.docs) {
        searchList.add(BodyOrigin.fromJson(element.data() as Map<String, dynamic>));
      }
      for (var element in bodyDataEnLower.docs) {
        searchList.add(BodyOrigin.fromJson(element.data() as Map<String, dynamic>));
      }

      // Add Arabic search results to searchList
      for (var element in bodyDataAr.docs) {
        searchList.add(BodyOrigin.fromJson(element.data() as Map<String, dynamic>));
      }

      emit(GetSearchpData()); // Emit the state with searchList
    } catch (e) {
      emit(GetSearchFailed(errorMessage: 'Error'));
    }
  }
}
