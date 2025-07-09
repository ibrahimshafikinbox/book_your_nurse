import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/colors.dart';
import 'circledata.dart';

class ActiveIngredientsWidget extends StatelessWidget {
  final List<String>? activeIngredients;

  const ActiveIngredientsWidget({super.key, required this.activeIngredients});

  @override
  Widget build(BuildContext context) {
    // Ensure activeIngredients is not null before using it
    if (activeIngredients == null || activeIngredients!.isEmpty) {
      return const Center(
        child: Text('No active ingredients available'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: activeIngredients!.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // Adds vertical spacing between items
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to start
            children: [
              const CircleContainer(),
              const SizedBox(width: 8.0), // Adds horizontal spacing between circle and text
              Expanded(
                child: Text(
                  activeIngredients![index],
                  style: GoogleFonts.inter(
                    color: AppColor.kPrimaryColor1,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
