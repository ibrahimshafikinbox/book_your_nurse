// booking_cubit.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/presentation/Booking/cubitt/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  // Future<void> createBooking({
  //   required String userId, // nurse UID
  //   required String houseNumber,
  //   required String streetNumber,
  //   required String fullAddress,
  //   required DateTime bookingDate, // contains both date and time
  // }) async {
  //   try {
  //     emit(BookingLoading());
  //     print("✅ create booking called");

  //     // Prepare booking data
  //     final bookingData = {
  //       'houseNumber': houseNumber,
  //       'streetNumber': streetNumber,
  //       'fullAddress': fullAddress,
  //       'bookingDate': bookingDate.toIso8601String(),
  //       'date':
  //           "${bookingDate.year}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
  //       'time':
  //           "${bookingDate.hour.toString().padLeft(2, '0')}:${bookingDate.minute.toString().padLeft(2, '0')}",
  //       'createdAt': FieldValue.serverTimestamp(),
  //     };

  //     // Save to Firestore under `nurses/{userId}/bookings`
  //     await FirebaseFirestore.instance
  //         .collection('nurse')
  //         .doc(userId)
  //         .collection('bookings')
  //         .add(bookingData);

  //     emit(BookingCreated());
  //     print("✅ Booking created successfully");
  //   } catch (e) {
  //     print("❌ Booking creation failed: $e");
  //     emit(BookingError("Failed to create booking"));
  //   }
  // }
  Future<void> createBooking({
    required String userId, // nurse UID
    required String houseNumber,
    required String streetNumber,
    required String fullAddress,
    required DateTime bookingDate, // contains both date and time
  }) async {
    try {
      emit(BookingLoading());
      print("✅ create booking called");

      // Step 1: Check if nurse document exists
      final nurseDoc = await FirebaseFirestore.instance
          .collection('nurse')
          .doc(userId)
          .get();

      if (!nurseDoc.exists) {
        print("❌ Nurse with ID $userId not found. Skipping booking.");
        emit(BookingError("Nurse not found. Cannot create booking."));
        return;
      }

      // Step 2: Prepare booking data
      final bookingData = {
        'houseNumber': houseNumber,
        'streetNumber': streetNumber,
        'fullAddress': fullAddress,
        'bookingDate': bookingDate.toIso8601String(),
        'date':
            "${bookingDate.year}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        'time':
            "${bookingDate.hour.toString().padLeft(2, '0')}:${bookingDate.minute.toString().padLeft(2, '0')}",
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Step 3: Save booking
      await FirebaseFirestore.instance
          .collection('nurse')
          .doc("IDTBVOgfEkY5fzIezXxPdoRD3bb2")
          .collection('bookings')
          .add(bookingData);

      emit(BookingCreated());
      print("✅ Booking created successfully");
    } catch (e) {
      print("❌ Booking creation failed: $e");
      emit(BookingError("Failed to create booking"));
    }
  }
}
