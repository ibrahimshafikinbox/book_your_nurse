part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}
class GetSearchploading extends SearchState {}
class GetSearchpData extends SearchState {} // This state should be used with List<BodyOrigin>
class EmptyState extends SearchState {}
class GetSearchFailed extends SearchState {
  final String errorMessage;
  GetSearchFailed({required this.errorMessage});
}
class MedicineSearchploading extends SearchState {}

class MedicineSearchDataSuccessful extends SearchState {
  final List<Drug> searchResults1; // This state should be used with List<Drug>
  MedicineSearchDataSuccessful({required this.searchResults1});
}

class MedicineSearchDataError extends SearchState {
  final String errorMessage;
  MedicineSearchDataError({required this.errorMessage});
}
class MedicineSearchLoading extends SearchState {}

class MedicineSearchSuccessful extends SearchState {}

class MedicineSearchError extends SearchState {
  final String error;
  MedicineSearchError({required this.error});
}