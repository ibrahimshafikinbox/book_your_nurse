import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import '../../../app/style/custom_text.dart';

class MedicineContainer extends StatelessWidget {
  const MedicineContainer({
    super.key,
    required this.photo,
    required this.name,
    required this.quantatiy,
    required this.active,
    this.onTap,
  });

  final String photo;
  final String name;
  final String quantatiy;
  final String active;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Set preferred orientations based on width
    if (width < 500) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xffE8F3F1),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width < 500
                  ? 0
                  : width < 800
                      ? 0.0125 * width
                      : MediaQuery.of(context).size.width < 1200
                          ? 0.0416666666666667 * width
                          : 0.0184615384615385 * width,
            ),
            // Use CachedNetworkImage for image loading
            // Use CachedNetworkImage for image loading
            CachedNetworkImage(
              imageUrl: photo,
              width: MediaQuery.of(context).size.width < 325
                  ? 0.4658385093167702 * width
                  : MediaQuery.of(context).size.width < 500
                      ? 0.3730103806228374 * width
                      : MediaQuery.of(context).size.width < 800
                          ? 0.475 * width
                          : MediaQuery.of(context).size.width < 1200
                              ? 0.50 * width
                              : 0.50 * width,
              height: MediaQuery.of(context).size.width < 325
                  ? 0.4658385093167702 * width
                  : MediaQuery.of(context).size.width < 500
                      ? 0.1730103806228374 * height
                      : MediaQuery.of(context).size.width < 800
                          ? 0.175 * height
                          : MediaQuery.of(context).size.width < 1200
                              ? 0.16 * height
                              : 0.284615384615384 * height,
              placeholder: (context, url) => Center(
                child: Lottie.asset(
                  'Image/CircularIndicatorLottie.json',
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200], // Placeholder color
                alignment: Alignment.center,
                child: const Text('Image not available',
                    style: TextStyle(color: Colors.red)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width < 500
                  ? 10
                  : MediaQuery.of(context).size.width < 800
                      ? 0
                      : MediaQuery.of(context).size.width < 1200
                          ? 10
                          : 40,
            ),
            Row(
              children: [
                SizedBox(
                  width: width < 500
                      ? 20
                      : width < 800
                          ? 20
                          : 20,
                ),
                Expanded(
                  child: CustomText(
                    text: name,
                    fontWeight: FontWeight.w600,
                    fontSize: width < 500
                        ? 0.03 * width
                        : width < 800
                            ? 0.02875 * width
                            : 0.02375 * width,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: width < 500
                      ? 20
                      : width < 800
                          ? 20
                          : 20,
                ),
                Expanded(
                  child: CustomText(
                    text: "$active  $quantatiy",
                    fontWeight: FontWeight.w500,
                    fontSize: width < 500
                        ? 0.028 * width
                        : width < 800
                            ? 0.02225 * width
                            : 0.01899 * width,
                    maxLines: 1,
                    colorText: const Color(0xffADADAD),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
