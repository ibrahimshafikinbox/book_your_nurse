class Booking {
  final int bookingId;
  final String userId;
  final String providerId;
  final DateTime bookingDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.providerId,
    required this.bookingDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json['booking_id'] as int,
        // Convert to String safely
        userId: json['user_id'].toString(),
        providerId: json['provider_id'].toString(),
        bookingDate: DateTime.parse(json['booking_date'] as String),
        status: json['status'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );
}

// booking_state.dart
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingCreated extends BookingState {
  BookingCreated();
}

class BookingError extends BookingState {
  final String message;

  BookingError(this.message);
}
