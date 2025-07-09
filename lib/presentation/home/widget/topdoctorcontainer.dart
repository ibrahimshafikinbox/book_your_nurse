import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/colors.dart';

class TopDoctorContainer extends StatefulWidget {
  final String photoUrl;
  final String doctorname;
  final String city;
  final void Function()? onTap;

  const TopDoctorContainer({
    super.key,
    required this.photoUrl,
    required this.doctorname,
    required this.onTap, required this.city,
  });

  @override
  State<TopDoctorContainer> createState() => _TopDoctorContainerState();
}

class _TopDoctorContainerState extends State<TopDoctorContainer> {
  @override
  Widget build(BuildContext context) {
    // double height=MediaQuery.of(context).size.height;
    // double width=MediaQuery.of(context).size.width;

    return  GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffFFFFFF),
              border: Border.all(color: const Color(0xffE8F3F1))),
          height:150.67,
          width: 120,
          child: Column(
            children: [
              const SizedBox(
                height:10,
              ),
       Center(
         child:        CircleAvatar(
           radius:35.50000000000002,
           backgroundImage: NetworkImage(widget.photoUrl),
         ),
       ),

              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible( // Wrap with Flexible
                    child: Text(
                      "Dr.${widget.doctorname}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        color:  AppColor.kText1,
                        fontWeight: FontWeight.w600,
                        fontSize:12,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 5,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width:5,
                  ),
                  const SizedBox(
                    width: 0.9999999999999999,
                  ),
                  const Icon(
                    Icons.location_on_sharp,
                    size: 15,
                    color: AppColor.kPrimaryColor1,
                  ),
                  Flexible( // Wrap with Flexible
                    child: Text(
                      widget.city,

                      style: GoogleFonts.inter(

                          fontWeight: FontWeight.w500,
                          fontSize: 0.0194647201946472 *
                              MediaQuery.of(context).size.width,
                          color: AppColor.ratingColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
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
