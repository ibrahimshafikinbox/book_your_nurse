import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/colors.dart';

class DoctorDetailsContainer2 extends StatelessWidget {
  final String photoUrl;
  final String doctorName;
  final String city;
  const DoctorDetailsContainer2({
    super.key,
    required this.photoUrl,
    required this.doctorName,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.048661800486618 * width),
            color: AppColor.kWhite,
            border: Border.all(
              color: AppColor.kColorCircle,
            ),
          ),
          width: 0.9926520681265207 * width,
          height: 0.1441753171856978 * height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 0.024330900243309 * width,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.024330900243309 * width),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.0057670126874279 * height,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.024330900243309 * width),
                      child: Image.network(
                        photoUrl,
                        width: 0.267639902676399 * width,
                        height: 0.1268742791234141 * height,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 0.024330900243309 * width,
              ),
              // FIX: Wrap this Column in Expanded to avoid overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.0115340253748558 * height,
                    ),
                    Text(
                      "Dr.$doctorName",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 0.0437956204379562 * width,
                        color: AppColor.kText1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: height * 0.0057670126874279,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                height * 0.0072992700729927),
                            color: AppColor.kColorCircle,
                          ),
                          child: Row(
                            children: [
                              // Add any other child widgets if needed
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.0057670126874279 * height,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          size: 0.0334963503649635 * width,
                          color: AppColor.kPrimaryColor1,
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 0.0270001003163017 * width,
                              color: AppColor.kPrimaryColor1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}