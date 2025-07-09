
import 'package:flutter/material.dart';
import '../app/style/custom_icon.dart';
import '../app/style/custom_text.dart';

class ShowAlert
{
  static Future<void> showErrorORWarningDialog({
    required BuildContext context,
    required String subtitle,
    required Function fct,
    bool isError = true,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomIcon(
                    icon: Icons.close_rounded,
                  color: Colors.red,
                  size: 30,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomText(
                  text: subtitle,
                  fontWeight: FontWeight.w600,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const CustomText(
                            text: "Cancel",
                            colorText: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        fct();
                        Navigator.pop(context);
                      },
                      child: const CustomText(
                          text: "OK",
                          colorText: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: CustomText(
                text: "Choose option",
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        cameraFCT();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.lightBlue,
                      ),
                      label: const CustomText(
                        text: "Camera",
                        colorText: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        galleryFCT();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.lightBlue,
                      ),
                      label: const CustomText(
                        text: "Gallery",
                        colorText: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        removeFCT();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.lightBlue,
                      ),
                      label: const CustomText(
                        text: "Remove",
                        colorText: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}

