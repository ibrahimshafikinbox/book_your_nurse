
import 'package:flutter/material.dart';
import 'package:medical_app/presentation/chat/model/messages_model.dart';

import '../../../const/colors.dart';

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    super.key,
    required this.height,
    required this.width,
    required this.messagesModel,
  });

  final double height;
  final double width;
  final MessagesModel messagesModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        //width: width / 1.5,
        margin: EdgeInsets.all(height / 70),
        padding: EdgeInsets.only(
          left: width / 40,
          top: width / 25,
          right: width / 35,
          bottom: width / 25,
        ),
        decoration: BoxDecoration(
          color: AppColor.kText2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(height / 18),
            bottomLeft: Radius.circular(height / 18),
            bottomRight: Radius.circular(height / 18),
          ),
        ),
        child: Column(
          children: [
            Text(
              messagesModel.message!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}