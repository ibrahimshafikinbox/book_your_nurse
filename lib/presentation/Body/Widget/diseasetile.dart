import 'package:flutter/material.dart';
import '../../../app/style/custom_text.dart';
import '../../../const/colors.dart';

class DiseaseTile extends StatelessWidget {
  final String diseaseName;
  final String diseaseNameArabic;
  final int percentage;
  final String currentLanguageCode;
  final bool isSelected;
  final void Function()? onTap;

  const DiseaseTile({super.key,
    required this.diseaseName,
    required this.diseaseNameArabic,
    required this.percentage,
    required this.currentLanguageCode,
    required this.isSelected,
    this.onTap,
  });

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

  // Helper method to build the progress bar
  Widget _buildProgressBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 20;
    final progressBarHeight = _calculateFontSize(context);

    return Stack(
      children: [
        Container(
          height: progressBarHeight,
          width: width,
          color: Colors.grey,
        ),
        Container(
          height: progressBarHeight,
          width: width * (percentage / 100),
          color: Colors.white,
        ),
      ],
    );
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
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        tileColor: isSelected ? Colors.blue : AppColor.kPrimaryColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: CustomText(
          text: currentLanguageCode == 'ar'
              ? diseaseNameArabic
              : diseaseName,
          colorText: Colors.white,
          fontSize: _calculateFontSize(context),
          maxLines: 60,
        ),
        subtitle: _buildProgressBar(context),
      ),
    );
  }
}
