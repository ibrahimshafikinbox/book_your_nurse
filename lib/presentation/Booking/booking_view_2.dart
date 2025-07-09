// import 'package:flutter/material.dart';
// import 'package:grad_project/Core/Helper/naviagation_helper.dart';
// import 'package:grad_project/Core/widget/app_Bar.dart';
// import 'package:grad_project/Feature/Booking/book_customer/booking_summury_3.dart';
// import 'package:grad_project/Feature/Login/Widget/app_button.dart';
// import 'package:grad_project/Feature/resources/colors/colors.dart';
// import 'package:table_calendar/table_calendar.dart';

// class BookingSelectDate_2 extends StatefulWidget {
//   @override
//   _BookingSelectDate_2State createState() => _BookingSelectDate_2State();
// }

// class _BookingSelectDate_2State extends State<BookingSelectDate_2> {
//   DateTime? selectedDate;
//   String? selectedTime;

//   final List<String> amTimes = ['09:00', '10:00', '11:00', '12:00'];
//   final List<String> pmTimes = ['01:00', '02:00', '03:00', '04:00'];
//   final List<String> eveningTimes = ['05:00', '06:00', '07:00', '08:00'];

//   void _selectDate(DateTime date, DateTime focusedDay) {
//     setState(() {
//       selectedDate = date;
//     });
//   }

//   void _selectTime(String time) {
//     setState(() {
//       selectedTime = time;
//     });
//   }

//   void _submitBooking() {
//     if (selectedDate != null && selectedTime != null) {
//       // Process the booking
//       print('Selected Date: $selectedDate');
//       print('Selected Time: $selectedTime');
//       // Navigate to the next screen or perform other actions
//     } else {
//       // Show an error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a date and time')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: CustomAppBar(
//         title: 'Electrician booking',
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'Select Date',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: TableCalendar(
//                   firstDay: DateTime.now(),
//                   lastDay: DateTime(2025, 12, 31),
//                   focusedDay: selectedDate ?? DateTime.now(),
//                   onDaySelected: (selectedDay, focusedDay) =>
//                       _selectDate(selectedDay, focusedDay),
//                   calendarFormat: CalendarFormat.month,
//                   headerStyle: HeaderStyle(
//                     formatButtonVisible: false,
//                     titleCentered: true,
//                   ),
//                   calendarStyle: CalendarStyle(
//                     todayDecoration: BoxDecoration(
//                       color: Color(0Xff165BB3),
//                       shape: BoxShape.circle,
//                     ),
//                     selectedDecoration: BoxDecoration(
//                       color: Color(0Xff165BB3),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Select Hours',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               _buildTimeSection('AM', amTimes),
//               _buildTimeSection('PM', pmTimes),
//               SizedBox(height: 20),
//               DefaultButton(
//                   function: () {
//                     navigateTo(context, ReviewSummaryScreen());
//                   },
//                   text: 'Next',
//                   textColor: AppColors.white)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeSection(String title, List<String> times) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//         Wrap(
//           spacing: 8.0,
//           children: times
//               .map((time) => ChoiceChip(
//                     disabledColor: AppColors.white,
//                     label: Text(time),
//                     selected: selectedTime == time,
//                     selectedColor: Color(0Xff165BB3),
//                     iconTheme: IconThemeData(color: Colors.white),
//                     labelStyle: TextStyle(
//                       color: selectedTime == time ? Colors.white : Colors.black,
//                     ),
//                     onSelected: (selected) => _selectTime(time),
//                   ))
//               .toList(),
//         ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }
// BookingSelectDate_2.dart
import 'package:flutter/material.dart';
import 'package:medical_app/presentation/Booking/app_button.dart';
import 'package:medical_app/presentation/Booking/booking_summury_3.dart';

import 'package:medical_app/presentation/resources/colors/colors.dart';
import 'package:medical_app/presentation/resources/styles/app_sized_box.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingSelectDate_2 extends StatefulWidget {
  final String userId;
  final String houseNumber;
  final String streetNumber;
  final String completeAddress;

  const BookingSelectDate_2({
    required this.userId,
    required this.houseNumber,
    required this.streetNumber,
    required this.completeAddress,
  });

  @override
  _BookingSelectDate_2State createState() => _BookingSelectDate_2State();
}

class _BookingSelectDate_2State extends State<BookingSelectDate_2> {
  DateTime? selectedDate;
  String? selectedTime;
  final List<String> timeSlots = [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00'
  ];

  DateTime _combineDateTime() {
    final timeParts = selectedTime!.split(':');
    return DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text('Select Date & Time')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildCalendar(),
              AppSizedBox.sizedH20,
              _buildTimeGrid(),
              AppSizedBox.sizedH20,
              DefaultButton(
                function: () {
                  if (selectedDate != null && selectedTime != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewSummaryScreen(
                          userId: widget.userId,
                          houseNumber: widget.houseNumber,
                          streetNumber: widget.streetNumber,
                          completeAddress: widget.completeAddress,
                          bookingDate: _combineDateTime(),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please select date and time')),
                    );
                  }
                },
                text: 'Next',
                textColor: AppColors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: selectedDate ?? DateTime.now(),
      onDaySelected: (day, _) => setState(() => selectedDate = day),
      calendarFormat: CalendarFormat.month,
      headerStyle: const HeaderStyle(formatButtonVisible: false),
      calendarStyle: CalendarStyle(
        todayDecoration: const BoxDecoration(
          color: AppColors.primaryL,
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: AppColors.primaryL,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildTimeGrid() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: timeSlots
          .map((time) => ChoiceChip(
                label: Text(time),
                selected: selectedTime == time,
                selectedColor: AppColors.primaryL,
                labelStyle: TextStyle(
                  color: selectedTime == time ? Colors.white : Colors.black,
                ),
                onSelected: (_) => setState(() => selectedTime = time),
              ))
          .toList(),
    );
  }
}
