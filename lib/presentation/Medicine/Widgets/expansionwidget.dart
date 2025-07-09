import 'package:flutter/material.dart';
import 'package:medical_app/app/style/custom_text.dart';


class Expansionwidget extends StatelessWidget {
  const Expansionwidget({super.key, required this.title, required this.sub});
final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.grey,
      child: ExpansionTile(
        title: Text(title),
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.center,
            child: CustomText(text: sub,fontWeight: FontWeight.w400,colorText: Colors.black,maxLines: 1000000,),
          ),
        ],
      ),
    );
  }
}
