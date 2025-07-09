import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/presentation/Booking/app_button.dart';
import 'package:medical_app/presentation/Booking/cubitt/booking_cubit.dart';
import 'package:medical_app/presentation/Booking/cubitt/booking_state.dart';
import 'package:medical_app/presentation/Booking/success_pop_Up.dart';
import 'package:medical_app/presentation/resources/colors/colors.dart';
import 'package:medical_app/presentation/resources/styles/app_sized_box.dart';
import 'package:medical_app/presentation/resources/styles/app_text_style.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final String userId;
  final String houseNumber;
  final String streetNumber;
  final String completeAddress;
  final DateTime bookingDate;

  const ReviewSummaryScreen({
    required this.userId,
    required this.houseNumber,
    required this.streetNumber,
    required this.completeAddress,
    required this.bookingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text("Summary")),
      body: BlocListener<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingCreated) {
            showOrderReceivedDialog(context);
          } else if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSummaryItem('House Number', houseNumber),
              _buildSummaryItem('Street Number', streetNumber),
              _buildSummaryItem('Address', completeAddress),
              _buildSummaryItem('Date',
                  "${bookingDate.day}/${bookingDate.month}/${bookingDate.year}"),
              _buildSummaryItem('Time',
                  "${bookingDate.hour}:${bookingDate.minute.toString().padLeft(2, '0')}"),
              AppSizedBox.sizedH40,
              BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const CircularProgressIndicator();
                  }
                  return AppButton(
                    function: () async {
                      print("Creating booking for user: $userId");
                      await context.read<BookingCubit>().createBooking(
                            userId: userId,
                            bookingDate: bookingDate,
                            houseNumber: houseNumber,
                            streetNumber: streetNumber,
                            fullAddress: completeAddress,
                          );
                    },
                    text: 'Confirm Booking',
                    textColor: AppColors.white,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.textStyleMediumBlack),
          Text(value, style: AppTextStyle.textStyleMediumBlack),
        ],
      ),
    );
  }
}
