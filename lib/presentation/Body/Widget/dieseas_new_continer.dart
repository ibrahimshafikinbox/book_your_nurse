import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Make sure to import Material package for InkWell
import '../../../app/style/custom_text.dart';

class DieseasNewcontiner extends StatefulWidget {
  const DieseasNewcontiner(
      {super.key, required this.title, required this.details});

  final String title;
  final String details;

  @override
  _DieseasNewcontinerState createState() => _DieseasNewcontinerState();
}

class _DieseasNewcontinerState extends State<DieseasNewcontiner> {
  bool _isDetailsVisible = false; // State to track visibility of details

  double _calculateTitleFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 500) {
      return width * 0.0572;
    } else if (width < 1100) {
      return width * 0.05;
    } else {
      return width * 0.02;
    }
  }

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
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isDetailsVisible = !_isDetailsVisible; // Toggle details visibility
            });
          },
          child: Row(
            children: [
              CustomText(
                text: widget.title,
                fontWeight: FontWeight.bold,
                fontSize: _calculateTitleFontSize(context),
                colorText: Colors.blue,
              )
            ],
          ),
        ),

        if (_isDetailsVisible) // Show details only if visible
          Row(
            children: [
              Expanded(
                child: CustomText(
                  text: widget.details,
                  fontSize: _calculateFontSize(context),
                  fontWeight: FontWeight.w400,
                  maxLines: 200,
                ),
              )
            ],
          ),

      ],
    );
  }
}
