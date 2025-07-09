import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog({
    required this.path,
    required this.text,
    super.key,
   this.onTap,
  });

  final String path;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          width: screenWidth * 0.9,
          height: screenHeight * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 123.3,
                height: 130.05,
                child: CircleAvatar(
                  backgroundColor: const Color(0xffF5F8FF),
                  radius: screenWidth * 0.07,
                  child: Center(
                    child: Image.asset(
                      path,
                      height: 87,
                      width: 42,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: SizedBox(
                  width: 205,
                  child: Text(
                    text,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  height: screenHeight / 17,
                  decoration: BoxDecoration(
                    color: const Color(0xff199A8E),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                    S.of(context).Choose,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02), // Add spacing between buttons
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: screenHeight / 17,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).Cancel,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
