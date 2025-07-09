import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rich_readmore/rich_readmore.dart';
import '../../../const/colors.dart';
import '../../../generated/l10n.dart';

class DiseaseInfo extends StatelessWidget {
  final String info;

  const DiseaseInfo({super.key, required this.info});

  // bool _isExpanded = false;

  // Helper method to calculate font size based on screen width
  double _calculateFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 500) {
      return width * 0.0472;
    } else if (width < 1100) {
      return width * 0.05;
    } else {
      return width * 0.02;
    }
  }

  // Converts English numbers to Arabic numbers
  String convertToArabicNumbers(String input) {
    const englishToArabicDigits = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };
    return input.replaceAllMapped(RegExp(r'[0-9]'), (match) {
      return englishToArabicDigits[match.group(0)]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        tileColor: AppColor.kPrimaryColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichReadMoreText.fromString(
              text: info,
              textStyle: GoogleFonts.inter(
                color: Colors.white,
                fontSize: _calculateFontSize(context),
              ),
              settings: LengthModeSettings(
                trimLength: 130,
                trimCollapsedText: S.of(context).Showmore,
                trimExpandedText: S.of(context).Showless,
                onPressReadMore: () {

                },
                lessStyle: GoogleFonts.inter(color: Colors.white),
                moreStyle: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
