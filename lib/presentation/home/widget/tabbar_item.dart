import 'package:flutter/material.dart';

import '../../../app/style/custom_text.dart';

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: title,
            fontSize: MediaQuery.of(context).size.width < 322
                ? MediaQuery.of(context).size.width * 0.0120
                : MediaQuery.of(context).size.width < 500
                    ? MediaQuery.of(context).size.width * 0.0302
                    : MediaQuery.of(context).size.width < 800
                        ? MediaQuery.of(context).size.width * 0.035
                        : MediaQuery.of(context).size.width * 0.02,
          )
        ],
      ),
    );
  }
}
