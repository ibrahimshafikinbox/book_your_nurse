import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final double height;
  // final Color background;
  final VoidCallback function;
  final String text;
  final bool isUpperCase;
  final double radius;
  final Color textColor;
  // final Color bottonColor;

  const DefaultButton({
    super.key,
    this.height = 50,
    required this.function,
    required this.text,
    this.isUpperCase = false,
    this.radius = 15.0,
    required this.textColor,
    // required this.bottonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: const Color.fromRGBO(22, 91, 179, 1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: function,
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final double height;
  // final Color background;
  final VoidCallback function;
  final String text;
  final bool isUpperCase;
  final double radius;
  final Color textColor;
  // final Color bottonColor;

  const AppButton({
    super.key,
    this.height = 50,
    required this.function,
    required this.text,
    this.isUpperCase = false,
    this.radius = 20.0,
    required this.textColor,
    // required this.bottonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: const Color.fromRGBO(22, 91, 179, 1)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: function,
              child: Text(
                isUpperCase ? text.toUpperCase() : text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
