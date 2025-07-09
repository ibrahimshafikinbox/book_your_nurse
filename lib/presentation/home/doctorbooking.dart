import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/presentation/home/widget/doctordetailscontainer2.dart';
import '../../../const/colors.dart';
import '../../app/style/custom_button.dart';
import '../Bottom/bottom.dart';


class DoctorBooking extends StatefulWidget {
  const DoctorBooking({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.address,
    required this.photoUrl,
    required this.city,
    required this.government,
    required this.reservation,
  });
  final String name;
  final String category;
  final double rating;
  final String address;
  final String photoUrl;
  final String city;
  final String government;
  final int reservation;

  static String id = 'DoctorBooking';

  @override
  State<DoctorBooking> createState() => _DoctorBookingState();
}

class _DoctorBookingState extends State<DoctorBooking> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double consultation = widget.reservation.toDouble();
    double adminFee = consultation * .10;
    double total = consultation + adminFee;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          "Appointment",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(width * 0.009930900243309),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DoctorDetailsContainer2(
                  photoUrl: widget.photoUrl,
                  doctorName: widget.name,
                  city: widget.city,
                ),
                SizedBox(height: 0.0115340253748558 * height),
                Row(
                  children: [
                    SizedBox(width: 0.024330900243309 * width),
                    Text(
                      "Date",
                      style: GoogleFonts.inter(
                        color: AppColor.kText1,
                        fontWeight: FontWeight.w600,
                        fontSize: 0.0364963503649635 * width,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      child: Text(
                        "Change",
                        style: GoogleFonts.inter(
                          color: AppColor.ratingColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 0.0316301703163017 * width,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 0.024330900243309 * width),
                    Container(
                      width: 0.0875912408759124 * width,
                      height: 0.041522491349481 * height,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.kColorCircle,
                      ),
                      child: SvgPicture.asset(
                        "Image/Icons/Calendar.svg",
                        width: 0.048661800486618 * width,
                        height: 0.0230680507497116 * height,
                        color: AppColor.kPrimaryColor1,
                      ),
                    ),
                    SizedBox(width: 0.024330900243309 * width),
                    Text(
                      "Wednesday, Jun 23, 2021 | 10:00 AM",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 0.0364963503649635 * width,
                        color: AppColor.dateColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.0115340253748558 * height),
                Container(
                  width: 0.8150851581508516 * width,
                  height: 0.0011534025374856 * height,
                  color: AppColor.kGrey3,
                ),
                SizedBox(height: 0.0034602076124567 * height),
                SizedBox(height: 0.0215340253748558 * height),
                Row(
                  children: [
                    SizedBox(width: 0.024330900243309 * width),
                    Text(
                      "Payment Detail",
                      style: GoogleFonts.inter(
                        color: AppColor.kText1,
                        fontWeight: FontWeight.w600,
                        fontSize: 0.0389294403892944 * width,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.0576701268742791 * height),
                Row(
                  children: [
                    SizedBox(width: 0.024330900243309 * width),
                    Text(
                      "Consultation",
                      style: GoogleFonts.inter(
                        color: AppColor.kText3,
                        fontWeight: FontWeight.w400,
                        fontSize: 0.0389294403892944 * width,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "$consultation EGP",
                      style: GoogleFonts.inter(
                        color: AppColor.ratingColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 0.0389294403892944 * width,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 0.0576701268742791 * height),
                Row(
                  children: [
                    SizedBox(width: 0.024330900243309 * width),
                    Text(
                      "Admin Fee",
                      style: GoogleFonts.inter(
                        color: AppColor.kText3,
                        fontWeight: FontWeight.w400,
                        fontSize: 0.0389294403892944 * width,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "$adminFee EGP",
                      style: GoogleFonts.inter(
                        color: AppColor.ratingColor,
                        fontWeight: FontWeight.w400,
                        fontSize: .0389294403892944 * width,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 0.0315340253748558 * height),
                Container(
                  width: 0.8150851581508516 * width,
                  height: 0.0011534025374856 * height,
                  color: AppColor.kGrey3,
                ),
                SizedBox(height: 0.0034602076124567 * height),
                SizedBox(height: 0.0215340253748558 * height),
                Row(
                  children: [
                    SizedBox(width: 0.024330900243309 * width),
                    Text(
                      "Total",
                      style: GoogleFonts.inter(
                        color: AppColor.kText1,
                        fontWeight: FontWeight.w600,
                        fontSize: 0.0389294403892944 * width,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "$total EGP",
                      style: GoogleFonts.inter(
                        color: AppColor.kText1,
                        fontWeight: FontWeight.w600,
                        fontSize: 0.0389294403892944 * width,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 0.0161361014994233 * height),
                Container(
                  width: 0.8150851581508516 * width,
                  height: 0.0011534025374856 * height,
                  color: AppColor.kGrey3,
                ),
                SizedBox(height: 0.0615340253748558 * height),
                Container(
                  width: 0.9150851581508516 * width,
                  height: 0.0576701268742791 * height,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: AppColor.kGrey3,
                  )),
                  child: Row(
                    children: [
                      SizedBox(width: 0.024330900243309 * width),
                      Text(
                        "Pay in the clinic",
                        style: GoogleFonts.inter(
                          color: AppColor.kText1,
                          fontWeight: FontWeight.w600,
                          fontSize: 0.0389294403892944 * width,
                        ),
                      ),
                      const Spacer(),
                      Checkbox(
                        value: isChecked,
                        activeColor: Colors.orange,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    IgnorePointer(
                      ignoring:
                          !isChecked, // Only clickable when isChecked is true
                      child: CustomButton(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Bottombar()),
                                (route) => false,
                          );

                        },
                        height: height * 0.0576701268742791,
                        width: width * 0.9472019464720195,
                        color: isChecked
                            ? AppColor.kPrimaryColor1
                            : Colors.grey, // Change color based on isChecked
                        borderRadius:
                            BorderRadius.circular(0.024330900243309 * width),
                        border: Border.all(
                          color: isChecked
                              ? AppColor.kPrimaryColor1
                              : Colors
                                  .grey, // Change border color based on isChecked
                        ),
                        text: 'Booking',
                        colorText: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Row(
//   children: [
//     SizedBox(width: 0.024330900243309*width),
//     Text(
//       "Reason",
//       style: GoogleFonts.inter(
//         color: AppColor.kText1,
//         fontWeight: FontWeight.w600,
//         fontSize: 0.0364963503649635*width,
//       ),
//     ),
//     Spacer(),
//     TextButton(
//       child: Text(
//         "Change",
//         style: GoogleFonts.inter(
//           color: AppColor.RatingColor,
//           fontWeight: FontWeight.w500,
//           fontSize: 0.0316301703163017*width,
//         ),
//       ),
//       onPressed: () {},
//     )
//   ],
// ),
