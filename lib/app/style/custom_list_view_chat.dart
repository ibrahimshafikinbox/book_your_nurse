import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/presentation/chat/model/chat_model.dart';
import 'package:medical_app/presentation/profile_user/model/user_model.dart';
import '../../const/navigations.dart';
import '../../presentation/chat/model/messages_model.dart';
import '../../presentation/chat/messages_view.dart';
import 'custom_icon.dart';
import 'custom_text.dart';

class CustomListViewChat extends StatelessWidget {
  const CustomListViewChat({
    super.key,
    required this.chatModel,
  });
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    userId = chatModel.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid)
        .first;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(kUsersCollections)
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          userModel = UserModel.fromJson(snapshot.data!.data()!);
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: GestureDetector(
              onTap: () {
                print('${userModel!.name} NAME3');
                pushNamed(context, MessagesView.id, {
                  'chatModel': chatModel,
                  'userModel': userModel,
                  'userId': userId,
                });
              },
              child: Container(
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //'Image/on_boarding2.png'
                      if (userModel!.image != '')
                        ClipOval(
                          child: Image.network(
                            userModel!.image!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress){
                              if(loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.kWhite,
                                ),
                              );
                            },
                            errorBuilder: (context, object, stack){
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[350],
                                ),
                              );
                            },
                          ),
                        )
                      else
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[350],
                          ),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: userModel!.name!,
                              colorText: AppColor.kText1,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              //  userModel!.about!
                              //  chatModel.lastMessage
                              text: chatModel.lastMessage == '' ||
                                      chatModel.lastMessage == []
                                  ? userModel!.about!
                                  : chatModel.lastMessage!,
                              colorText: AppColor.kText3,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: CustomText(
                              text: DateFormat.Hm()
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(chatModel.lastMessageTime
                                          .toString())))
                                  .toString(),
                              maxLines: 1,
                              fontWeight: FontWeight.w700,
                              fontSize: 10.5,
                              colorText: AppColor.kText3,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(kRoomsCollections)
                                .doc(chatModel.id)
                                .collection(kMessage)
                                .snapshots(),
                            builder: (context, snapshots) {
                              final unReadList = snapshots.data?.docs
                                      .map((e) =>
                                          MessagesModel.fromJson(e.data()))
                                      .where((element) => element.read == '')
                                      .where((element) =>
                                          element.fromId !=
                                          FirebaseAuth
                                              .instance.currentUser!.uid) ??
                                  [];
                              return Container(
                                decoration: const BoxDecoration(
                                  color: AppColor.kPrimaryColor1,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: unReadList.length != 0
                                      ? Padding(
                                          padding: const EdgeInsets.all(6.5),
                                          child: CustomText(
                                            text: unReadList.length.toString(),
                                            colorText: AppColor.kWhite,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: CustomIcon(
                                            icon: Icons.check,
                                            color: AppColor.kWhite,
                                            size: 14,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator(
            color: AppColor.kPrimaryColor1,
          );
        }
      },
    );
  }
}

// ListTile(
// onTap: () {},
// leading: CircleAvatar(
// radius: 30,
// ),
// title: CustomText(
// text: 'Dr. Mohamed Omar',
// colorText: AppColor.kText1,
// fontWeight: FontWeight.w700,
// fontSize: 16,
// maxLines: 1,
// ),
// subtitle: CustomText(
// text: "I don't have any fever, but headchace",
// colorText: AppColor.kText3,
// fontWeight: FontWeight.w600,
// fontSize: 13,
// maxLines: 1,
// ),
// trailing: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// CustomText(
// text: '10:24',
// fontWeight: FontWeight.w600,
// fontSize: 12,
// colorText: AppColor.kText4,
// ),
// Container(
// decoration: BoxDecoration(
// color: AppColor.kPrimaryColor1,
// shape: BoxShape.circle,
// ),
// child: Center(
// child: Padding(
// padding: const EdgeInsets.all(6.5),
// child: CustomText(
// text: '1',
// colorText: AppColor.kWhite,
// fontSize: 11,
// fontWeight: FontWeight.w600,
// ),
// ),
// ),
// ),
// ],
// ),
// ),
