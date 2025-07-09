import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/colors.dart';

class Collection extends StatelessWidget {
  final void Function() onTap; // Define onTap as a final variable
  final String svg;
  final String displayText; // Rename Text to displayText
  const Collection({super.key,
    required this.onTap,
    required this.svg,
    required this.displayText,
  }); // Correct the syntax here

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
           padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child: SvgPicture.network(
height: 30,width: 25,
              svg,
              alignment: Alignment.center,
            ),
          ),

          Text(
            displayText,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width <
                    500
                    ? MediaQuery.of(context).size.width * 0.0352
                    : MediaQuery.of(context).size.width < 800
                    ? MediaQuery.of(context).size.width *
                    0.03
                    : MediaQuery.of(context).size.width *
                    0.02,
              color: AppColor.kText3
            ), // Use the renamed variable
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
