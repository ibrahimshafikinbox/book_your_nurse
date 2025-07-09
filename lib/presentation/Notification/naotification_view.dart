import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_app/presentation/resources/colors/colors.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0XFF165BB3),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18)),
                    child: Center(
                      child: DropdownButton<String>(
                        value: "Recent",
                        icon:
                            Icon(Icons.arrow_drop_down, color: AppColors.black),
                        dropdownColor: Color(0XFF165BB3),
                        underline: SizedBox(),
                        items: ["Recent", "Older"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: AppColors.black)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "Image/partspngfigma/notification.png",
                  height: 100,
                ),
                SizedBox(height: 16),
                Text(
                  "No Notifications!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "You don’t have any notification yet.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
