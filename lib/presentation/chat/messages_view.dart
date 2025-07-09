import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/const/navigations.dart';
import 'package:medical_app/presentation/chat/model/chat_model.dart';
import 'package:medical_app/presentation/chat/model/messages_model.dart';
import 'package:medical_app/presentation/profile_user/model/user_model.dart';
import 'package:medical_app/presentation/chat/widget/chat_buble_for_me.dart';
import 'package:medical_app/services/fire_chat.dart';
import '../../../const/chat_const.dart';
import '../../../generated/l10n.dart';
import '../../app/style/Custom_appbar.dart';
import '../../app/style/custom_icon.dart';
import '../../app/style/custom_icon_button.dart';
import '../../app/style/custom_text.dart';
import '../Bottom/bottom.dart';
import '../auth/auth_cubit/auth_cubit.dart';
import '../auth/auth_cubit/auth_states.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({
    super.key,
  });
  static String id = 'messages';

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  void initState() {
    super.initState();
  print('${  userModel!.name!} ${  userModel!.name!}  /////////OMAR');

  }

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Map<String,dynamic> arg = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    ChatModel chatModel = arg['chatModel'] as ChatModel;
    UserModel userModel3 =arg['userModel'] as UserModel;
    String toId = arg['userId'] as String;
    // userId = chatModel.members!.where((element) =>
    // element != FirebaseAuth.instance.currentUser!.uid).first;

    //String userId = chatModel!.members!.where((element) =>
    //element != FirebaseAuth.instance.currentUser!.uid).first;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, AuthStates) {
          return Scaffold(
            appBar: CustomAppBar(
              elevation: 0,
              toolbarHeight: height / 11,
              centerTitle: false,
              backgroundColor: AppColor.kWhite,
              leading: CustomIconButton(
                onPressed: () {
Navigator.pop(context);                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.kText1,
                ),
              ),
              title: const CustomText(
                //text: userModel3.name!,
                text: 'Chat in Medical',
                colorText: AppColor.kText1,
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
              // actions: [
              //   Padding(
              //     padding: EdgeInsets.only(
              //       top: height / 27,
              //       right: width / 30,
              //     ),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         if (selectedMsg.isNotEmpty)
              //           CustomIconButton(
              //             onPressed: ()  {
              //               setState(() {
              //                 FireChat().deleteMessage(
              //                     chatModel.id.toString(),
              //                     selectedMsg);
              //                 selectedMsg.clear();
              //                 copyMsg.clear();
              //               });
              //             },
              //             icon: Icon(
              //               Icons.delete_outline_sharp,
              //               color: AppColor.kText3,
              //               size: 25,
              //             ),
              //           )
              //         else Container(),
              //         CustomIconButton(
              //           onPressed: () {
              //             Clipboard.setData(ClipboardData(
              //               text: copyMsg.join(" \n"),
              //             ));
              //             setState(() {
              //               copyMsg.clear();
              //               selectedMsg.clear();
              //             });
              //           },
              //           icon: Icon(
              //             Icons.copy_rounded,
              //             color: AppColor.kText3,
              //             size: 25,
              //           ),
              //         ),
              //         // selectedMsg.isNotEmpty ?
              //         // GestureDetector(
              //         //   onTap: () {
              //         //     FireChat().deleteMessage(
              //         //         roomId.toString(),
              //         //         selectedMsg
              //         //     );
              //         //     setState(() {
              //         //       selectedMsg.clear();
              //         //       copyMsg.clear();
              //         //     });
              //         //   },
              //         //   child: CustomIcon(
              //         //     icon: Icons.delete_outline_sharp,
              //         //     color: AppColor.kText3,
              //         //     size: 30,
              //         //   ),
              //         // )
              //         // : Container(),
              //         // SizedBox(
              //         //   width: width / 40,
              //         // ),
              //         // GestureDetector(
              //         //   onTap: () {
              //         //     Clipboard.setData(ClipboardData(
              //         //         text: copyMsg.join(" \n"),
              //         //     ));
              //         //     setState(() {
              //         //       copyMsg.clear();
              //         //       selectedMsg.clear();
              //         //     });
              //         //   },
              //         //   child: CustomIcon(
              //         //     icon: Icons.copy_rounded,
              //         //     color: AppColor.kText3,
              //         //     size: 30,
              //         //   ),
              //         // ),
              //       ],
              //     ),
              //   ),
              // ],
            ),
            body: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(kRoomsCollections)
                      .doc(  chatModel.id.toString())
                      .collection(kMessage)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MessagesModel> messageItems = snapshot.data!.docs
                          .map((e) => MessagesModel.fromJson(e.data()))
                          .toList()
                        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                      return messageItems.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  reverse: true,
                                  itemCount: messageItems.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      // onTap: () {
                                      //   setState(() {
                                      //     selectedMsg.isNotEmpty
                                      //         ? selectedMsg.contains(
                                      //                 messageItems[index].id)
                                      //             ? selectedMsg.remove(
                                      //                 messageItems[index].id)
                                      //             : selectedMsg.add(
                                      //                 messageItems[index].id!)
                                      //         : null;
                                      //     copyMsg.isNotEmpty
                                      //         ? copyMsg.contains(
                                      //                 messageItems[index]
                                      //                     .message)
                                      //             ? copyMsg.remove(
                                      //                 messageItems[index]
                                      //                     .message)
                                      //             : copyMsg.add(
                                      //                 messageItems[index]
                                      //                     .message!)
                                      //         : null;
                                      //   });
                                      // },
                                      // onLongPress: () {
                                      //   setState(() {
                                      //     selectedMsg.contains(
                                      //             messageItems[index].id)
                                      //         ? selectedMsg.remove(
                                      //             messageItems[index].id)
                                      //         : selectedMsg
                                      //             .add(messageItems[index].id!);
                                      //     print(selectedMsg);
                                      //     copyMsg.contains(
                                      //             messageItems[index].message)
                                      //         ? copyMsg.remove(
                                      //             messageItems[index].message)
                                      //         : copyMsg.add(
                                      //             messageItems[index].message!);
                                      //   });
                                      // },
                                      child: ChatBubble(
                                        height: height,
                                        width: width,
                                        messagesModel: messageItems[index],
                                        roomId:   chatModel.id.toString(),
                                        isSelected: selectedMsg
                                            .contains(messageItems[index].id),
                                        toId: toId,
                                      ),
                                    );
                                  }),
                            )
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                      FireChat().sendMessage(
                                        userModel!.name,
                                        'Hello 👋',
                                        chatModel.id.toString(),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 30,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Column(
                                        children: [
                                          CustomText(
                                            text: '👋',
                                            colorText: AppColor.kText1,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomText(
                                            text: 'Send Hello check hand',
                                            colorText: AppColor.kText1,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    }
                    return const Center(
                      child: CustomIcon(
                        icon: Icons.waving_hand,
                        color: Colors.yellow,
                        size: 30,
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 10,
                        ),
                        child: TextField(
                          controller: cubit.msgController,
                          decoration: InputDecoration(
                            constraints: BoxConstraints(
                              maxWidth: width / 1.28,
                            ),
                            hintText: S.of(context).messaging,
                            border: buildBorder(),
                            enabledBorder: buildBorder(),
                            focusedBorder: buildBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColor.kPrimaryColor1,
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconButton(
                        onPressed: () {
                          if (cubit.msgController.text.isNotEmpty) {
                            FireChat()
                                .sendMessage(
                              userModel3.name,
                              cubit.msgController.text,
                              chatModel.id.toString(),
                            )
                                .then((value) {
                              cubit.msgController.text = '';
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 30,
                          color: AppColor.kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: const BorderSide(
        color: AppColor.kPrimaryColor1,
      ),
    );
  }
}
