import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/colors.dart';
import 'package:rich_readmore/rich_readmore.dart';

class DoctorDetailsContainer extends StatelessWidget {
  final String photoUrl;
  final String doctorName;
  final String address;

  const DoctorDetailsContainer({
    super.key,
    required this.photoUrl,
    required this.doctorName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(0.0181654501216545 * width),
          child: Container(
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
                    borderRadius:
                        BorderRadius.circular(0.024330900243309 * width),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0.0057670126874279 * height,
                      ),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(0.024330900243309 * width),
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
                // FIX: Wrap details column in Expanded to avoid overflow
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
                              address,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 0.0316301703163017 * width,
                                color: AppColor.kPrimaryColor1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
        ),
        SizedBox(height: 0.0115340253748558 * height),
        Text(
          "About",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 0.0589294403892944 * width,
            color: AppColor.kText1,
          ),
        ),
        const SizedBox(height: 5),
        // Example long text with RichReadMore to avoid overflow
      ],
    );
  }
}

//Lorem ipsum dolor sit amet, consectetur adipiscing elicZXcazxvzcxvzvzcvzxczxadfsafasfasdfasdfasfasfasfasfasfsfaasfasdfasasfasfasfsaft, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...