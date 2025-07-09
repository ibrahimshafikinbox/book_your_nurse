// import 'package:flutter/material.dart';
// import 'package:grad_project/Core/Helper/naviagation_helper.dart';
// import 'package:grad_project/Core/widget/app_Bar.dart';
// import 'package:grad_project/Feature/Booking/book_customer/booking_view_2.dart';
// import 'package:grad_project/Feature/Login/Widget/app_button.dart';
// import 'package:grad_project/Feature/Settings/widget/chaange_success.dart';
// import 'package:grad_project/Feature/resources/colors/colors.dart';
// import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
// import 'package:grad_project/Feature/resources/styles/app_text_style.dart';

// // ignore: camel_case_types
// class BookingAddressForm_1 extends StatefulWidget {
//   const BookingAddressForm_1({super.key});

//   @override
//   _BookingAddressForm_1State createState() => _BookingAddressForm_1State();
// }

// class _BookingAddressForm_1State extends State<BookingAddressForm_1> {
//   final _formKey = GlobalKey<FormState>();
//   final _houseNumberController = TextEditingController();
//   final _streetNumberController = TextEditingController();
//   final _completeAddressController = TextEditingController();

//   @override
//   void dispose() {
//     _houseNumberController.dispose();
//     _streetNumberController.dispose();
//     _completeAddressController.dispose();
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Process the data
//       print('House Number: ${_houseNumberController.text}');
//       print('Street Number: ${_streetNumberController.text}');
//       print('Complete Address: ${_completeAddressController.text}');
//       // Navigate to the next screen or perform other actions
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: CustomAppBar(
//         title: 'Booking',
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               AppSizedBox.sizedH20,
//               buildLabel("House number"),
//               AppSizedBox.sizedH5,
//               buildDisabledFormField('House number'),
//               AppSizedBox.sizedH5,
//               buildLabel('Street number'),
//               AppSizedBox.sizedH5,
//               buildDisabledFormField('street number'),
//               AppSizedBox.sizedH5,
//               buildLabel('Complete Address'),
//               AppSizedBox.sizedH5,
//               buildDisabledFormField('Complete Address'),
//               AppSizedBox.sizedH40,
//               DefaultButton(
//                   function: () {
//                     navigateAndFinish(context, BookingSelectDate_2());
//                   },
//                   text: "Next",
//                   textColor: AppColors.white)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget buildLabel(String text) {
//   return Text(text, style: AppTextStyle.textStyleBoldBlack);
// }

// Widget buildDisabledFormField(String text) {
//   return SizedBox(
//     height: 50,
//     child: TextFormField(
//       initialValue: text,
//       readOnly: false,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.grey[200],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     ),
//   );
// }
// BookingAddressForm_1.dart
import 'package:flutter/material.dart';

import 'package:medical_app/presentation/Booking/app_button.dart';
import 'package:medical_app/presentation/Booking/booking_view_2.dart';
import 'package:medical_app/presentation/resources/colors/colors.dart';
import 'package:medical_app/presentation/resources/styles/app_sized_box.dart';
import 'package:medical_app/presentation/resources/styles/app_text_style.dart';

class BookingAddressForm_1 extends StatefulWidget {
  final String userId;

  const BookingAddressForm_1({
    super.key,
    required this.userId,
  });

  @override
  _BookingAddressForm_1State createState() => _BookingAddressForm_1State();
}

class _BookingAddressForm_1State extends State<BookingAddressForm_1> {
  final _formKey = GlobalKey<FormState>();
  final _houseNumberController = TextEditingController();
  final _streetNumberController = TextEditingController();
  final _completeAddressController = TextEditingController();

  @override
  void dispose() {
    _houseNumberController.dispose();
    _streetNumberController.dispose();
    _completeAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text('Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppSizedBox.sizedH20,
                _buildFormField('House number', _houseNumberController),
                AppSizedBox.sizedH15,
                _buildFormField('Street number', _streetNumberController),
                AppSizedBox.sizedH15,
                _buildFormField('Complete Address', _completeAddressController),
                AppSizedBox.sizedH40,
                DefaultButton(
                  function: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingSelectDate_2(
                            userId: widget.userId,
                            houseNumber: _houseNumberController.text,
                            streetNumber: _streetNumberController.text,
                            completeAddress: _completeAddressController.text,
                          ),
                        ),
                      );
                    }
                  },
                  text: "Next",
                  textColor: AppColors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.textStyleBoldBlack),
        AppSizedBox.sizedH5,
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Required field' : null,
        ),
      ],
    );
  }
}
