import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/colors.dart';

class TopDoctorContainer2 extends StatefulWidget {
  final String photoUrl; // corrected parameter name
  final String doctorName; // corrected parameter name
  final String category;
  final double rating; // Change type to double
  final String address; // corrected parameter name
  final String city;
  final void Function()? onTap;

  const TopDoctorContainer2({
    super.key,
    required this.photoUrl, // corrected parameter name
    required this.doctorName, // corrected parameter name
    required this.category,
    required this.rating,
    required this.address, // corrected parameter name
    required this.onTap,
    required this.city,
  });

  @override
  State<TopDoctorContainer2> createState() => _TopDoctorContainer2State();
}

class _TopDoctorContainer2State extends State<TopDoctorContainer2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.all(
            0.0121654501216545 * MediaQuery.of(context).size.width),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                0.048661800486618 * MediaQuery.of(context).size.width),
            color: AppColor.kWhite,
            border: Border.all(
              color: AppColor.kColorCircle,
            ),
          ),
          width: 0.8126520681265207 * MediaQuery.of(context).size.width,
          height: 0.1441753171856978 * MediaQuery.of(context).size.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 0.024330900243309 * MediaQuery.of(context).size.width,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      0.024330900243309 * MediaQuery.of(context).size.width),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 0.0057670126874279 *
                              MediaQuery.of(context).size.height,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              0.024330900243309 *
                                  MediaQuery.of(context).size.width),
                          child: Image.network(
                            widget.photoUrl,
                            width: 0.267639902676399 *
                                MediaQuery.of(context).size.width,
                            height: 0.1268742791234141 *
                                MediaQuery.of(context).size.height,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 0.024330900243309 * MediaQuery.of(context).size.width,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height:
                        0.0115340253748558 * MediaQuery.of(context).size.height,
                  ),
                  Text(
                    "Dr.${widget.doctorName}", // corrected usage
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 0.0437956204379562 *
                          MediaQuery.of(context).size.width,
                      color: AppColor.kText1,
                    ),
                  ),
                  Text(
                    widget.category,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.width *
                          0.0291970802919708,
                      color: AppColor.ratingColor,
                    ),
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height * 0.0057670126874279,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                0.0072992700729927 *
                                    MediaQuery.of(context).size.width),
                            color: AppColor.kColorCircle),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColor.kPrimaryColor1,
                                  size: 0.048661800486618 *
                                      MediaQuery.of(context).size.width,
                                ),
                                Text(
                                  "${widget.rating}", // corrected usage
                                  style: GoogleFonts.inter(
                                    fontSize: 0.0291970802919708 *
                                        MediaQuery.of(context).size.width,
                                    color: AppColor.kPrimaryColor1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        0.0057670126874279 * MediaQuery.of(context).size.height,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        size: 0.0334963503649635 *
                            MediaQuery.of(context).size.width,
                        color: AppColor.ratingColor,
                      ),
                      Text(
                        "${widget.address},${widget.city}", // corrected usage
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 0.0316301703163017 *
                                MediaQuery.of(context).size.width,
                            color: AppColor.ratingColor),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
