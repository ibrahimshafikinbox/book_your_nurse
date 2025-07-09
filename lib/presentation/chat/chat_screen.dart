// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical_app/cubits/chat_cubit/chat_states.dart';
// import 'package:medical_app/view/widgets/Custom_appbar.dart';
// import '../../../const/chat_const.dart';
// import '../../../const/colors.dart';
// import '../../../cubits/chat_cubit/chat_cubit.dart';
// import '../../../models/messages_model.dart';
// import '../../widgets/chat/chat_buble_for_friend.dart';
// import '../../widgets/chat/chat_buble_for_me.dart';
//
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//   static String id = 'ChatPage';
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     var email = ModalRoute.of(context)!.settings.arguments;
//     print('my email is $email');
//     CollectionReference messages =
//     FirebaseFirestore.instance.collection(kMessageCollections);
//
//     return BlocProvider(
//       create: (context) => ChatCubit(),
//       child: BlocConsumer<ChatCubit, ChatStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return StreamBuilder<QuerySnapshot>(
//             stream: messages
//                 .orderBy(
//               kCreatedAt,
//               descending: true,
//             ).snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<MessagesModel> messagesList = [];
//                 for (int i = 0; i < snapshot.data!.docs.length; i++) {
//                   messagesList
//                       .add(MessagesModel.fromJson(snapshot.data!.docs[i]));
//                 }
//                 ChatCubit cubit = ChatCubit.get(context);
//                 return Scaffold(
//                   appBar: CustomAppBar(
//
//                   ),
//                   body: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           reverse: true,
//                           controller: cubit.scrollController,
//                           itemCount: messagesList.length,
//                           itemBuilder: (context, index) {
//                             return messagesList[index].id == email
//                                 ? ChatBubble(
//                               messagesModel: messagesList[index],
//                               height: height,
//                               width: width,
//                             )
//                                 : ChatBubbleForFriend(
//                               height: height,
//                               width: width,
//                               messagesModel: messagesList[index],
//                             );
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(height / 80),
//                         child: TextField(
//                           controller: cubit.sendController,
//                           onSubmitted: (data) {
//                             messages.add({
//                               kMessage: data,
//                               kCreatedAt: DateTime.now().toString(),
//                               kId: email,
//                             });
//                             cubit.sendController.clear();
//                             cubit.scrollController.animateTo(
//                               0,
//                               //cubit.scrollController.position.maxScrollExtent,
//                               duration: const Duration(seconds: 1),
//                               curve: Curves.fastOutSlowIn,
//                             );
//                           },
//                           decoration: InputDecoration(
//                             hintText: 'Send Message',
//                             suffixIcon: const Icon(
//                               Icons.send,
//                               color: AppColor.kPrimaryColor1,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(height / 15),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(height / 15),
//                               borderSide: const BorderSide(
//                                 color: AppColor.kPrimaryColor1,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 ChatCubit cubit = ChatCubit.get(context);
//                 return Scaffold(
//                   appBar: AppBar(
//                     backgroundColor: AppColor.kPrimaryColor1,
//                     centerTitle: true,
//                     title: CustomAppBar(),
//                   ),
//                   body: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(height / 80),
//                         child: TextField(
//                           controller: cubit.sendController,
//                           onSubmitted: (data) {
//                             messages.add({
//                               kMessage: data,
//                               kCreatedAt: DateTime.now().toString(),
//                               kId: email,
//                             });
//                             cubit.sendController.clear();
//                             cubit.scrollController.animateTo(
//                               0,
//                               //cubit.scrollController.position.maxScrollExtent,
//                               duration: const Duration(seconds: 0),
//                               curve: Curves.fastOutSlowIn,
//                             );
//                           },
//                           decoration: InputDecoration(
//                             hintText: 'Send Message',
//                             suffixIcon: const Icon(
//                               Icons.send,
//                               color: AppColor.kPrimaryColor1,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(height / 15),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(height / 15),
//                               borderSide: const BorderSide(
//                                 color: AppColor.kPrimaryColor1,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
