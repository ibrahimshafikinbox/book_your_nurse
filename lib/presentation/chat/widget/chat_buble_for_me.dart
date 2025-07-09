

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/presentation/chat/model/messages_model.dart';
import 'package:medical_app/services/fire_chat.dart';

import '../../../app/style/custom_icon.dart';
import '../../../app/style/custom_text.dart';
import '../../../const/colors.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    super.key,
    required this.height,
    required this.width,
    required this.messagesModel,
    required this.roomId,
    required this.isSelected, required this.toId,
  });

  final double height;
  final double width;
  final String toId;
  final MessagesModel messagesModel;
  final String roomId;
  final bool isSelected;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {

  @override
  void initState() {
    bool isNotMe = widget.messagesModel.fromId !=
        FirebaseAuth.instance.currentUser!.uid;


    print('$isNotMe OMAR 222');

    if(isNotMe){
      FireChat().readMessages(
        widget.roomId,
        widget.messagesModel.id!,
      );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isMe = widget.messagesModel.fromId ==
    FirebaseAuth.instance.currentUser!.uid;
    return Align(
      alignment: isMe ?
      Alignment.centerLeft
      :Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(
          left: widget.width / 30,
          top: widget.width / 25,
          right: widget.width / 35,
          bottom: widget.width / 25,
        ),
        margin: const EdgeInsets.only(
          top: 5,
          bottom: 10,
          right: 10,
          left: 10,
        ),
        decoration: BoxDecoration(
          color: widget.isSelected == false ?
          isMe ?
          AppColor.kGreen1
          : Theme.of(context).colorScheme.primaryContainer
          : AppColor.kText3,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMe ? 0 : 16),
            topRight: Radius.circular(isMe ? 16 : 0),
            bottomLeft: const Radius.circular(16),
            bottomRight: const Radius.circular(16),
          ),
         ),
        child: Column(
          crossAxisAlignment: isMe?
          CrossAxisAlignment.start
          : CrossAxisAlignment.end,
          children: [
            Text(
              widget.messagesModel.message!,
              textAlign: isMe ?
              TextAlign.start
                  : TextAlign.end,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: isMe ?
                AppColor.kBlack1
                    : AppColor.kBlack1,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isMe ?
              MainAxisAlignment.start
              : MainAxisAlignment.end,
              children: [
                isMe ?
                    CustomIcon(
                        icon: Icons.check,
                      size: 16,
                      color: widget.messagesModel.read == ''
                      ?AppColor.kText3
                      :Colors.blueAccent,
                    )
                :const SizedBox(width: 0,),
                const SizedBox(
                  width: 3,
                ),
                CustomText(
                  text: DateFormat.yMMMEd().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(widget.messagesModel.createdAt!))).toString(),
                  textAlign: isMe ?
                  TextAlign.start
                      : TextAlign.end,
                  fontWeight: FontWeight.w600,
                  colorText: isMe ?
                  AppColor.kText3:
                  AppColor.kText3,
                  fontSize: 10.5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}