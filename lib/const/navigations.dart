import 'package:flutter/material.dart';

void navigatePush(BuildContext context, widget) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigatePop(BuildContext context) => Navigator.of(context).pop(
      context,
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

void pushNamed(BuildContext context, widget, [Object? arguments]) {
  Navigator.pushNamed(
    context,
    widget,
    arguments: arguments,
  );
}

void pushReplacementNamed(BuildContext context, widget, [Object? arguments]) {
  Navigator.pushReplacementNamed(
    context,
    widget,
    arguments: arguments,
  );
}
  void pushNamedAndRemoveUntil(BuildContext context, widget, [Object? arguments]) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      widget,
      (route) => false,
      arguments: arguments,
    );
  }

