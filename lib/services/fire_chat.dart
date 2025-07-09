import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/presentation/chat/model/chat_model.dart';
import 'package:medical_app/presentation/chat/model/messages_model.dart';
import 'package:uuid/uuid.dart';


class FireChat {
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  final String myId = FirebaseAuth.instance.currentUser!.uid;
  String msgId = const Uuid().v1();
  List<String>? members;
  var isDoctor;
  Future createChat(String email, {required String collection}) async
  {
    QuerySnapshot userData = await firebaseFireStore
        .collection(collection)
        .where('email', isEqualTo: email).get();

    QuerySnapshot isDoctorr = await firebaseFireStore
        .collection(kUsersCollections)
        .where(kIsDoctor, isEqualTo: true).get();

     isDoctor = await firebaseFireStore
        .collection(kUsersCollections).doc(myId).collection(kIsDoctor).get();
    // var isDoctor1 = await firebaseFireStore
    //     .collection(kUsersCollections).doc(members![1]).collection(kIsDoctor).get();
    // print('ssss ${userModel!.isDoctor}');
    // print('ssss ${userModel!.name}');
    // print('ssss ${isDoctor.toString()}');
    //  && (isDoctor == true )
    if (userData.docs.isNotEmpty ) {

      String userId = userData.docs.first.id;
      members = [myId, userId]
        ..sort((a, b) => a.compareTo(b));

      QuerySnapshot roomSaved = await firebaseFireStore
          .collection(kRoomsCollections)
          .where(kMembers, isEqualTo: members).get();

      if (roomSaved.docs.isEmpty) {
        ChatModel chatModel = ChatModel(
          id: members.toString(),
          members: members,
          lastMessage: '',
          lastMessageTime: DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          createdAt: DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
        );
        await firebaseFireStore.collection(kRoomsCollections)
            .doc(members.toString())
            .set(chatModel.toJson());
      }
    }
  }

  Future sendMessage(String uId, String message, String roomId) async
  {
    MessagesModel messagesModel = MessagesModel(
      id: msgId,
      toId: uId,
      fromId: myId,
      message: message,
      type: 'text',
      createdAt: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      read: '',
    );
    await firebaseFireStore.collection(kRoomsCollections)
        .doc(roomId).collection(kMessage).doc(msgId)
        .set(messagesModel.toJson());
    if (kDebugMode) {
      print('my send : $msgId');
    }
    await firebaseFireStore.collection(kRoomsCollections)
        .doc(roomId).update({
      kLastMessage: message,
      kLastMessageTime: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
    });
  }

  Future readMessages(String roomId, String msgId) async {
    firebaseFireStore.collection(kRoomsCollections)
        .doc(roomId).collection(kMessage).doc(msgId)
        .update({kRead: DateTime
        .now()
        .millisecondsSinceEpoch
        .toString()});
  }

  // Future readMessages() async{
  //   firebaseFireStore.collection(kRoomsCollections)
  //       .doc(members.toString()).collection(kMessage).doc(msgId)
  //       .update({kRead : DateTime.now().millisecondsSinceEpoch.toString()});
  // }

  deleteMessage(String roomId, List<String> msgs,) async
  {
    if (selectedMsg.length == 1) {
      await firebaseFireStore.collection(kRoomsCollections)
          .doc(roomId).collection(kMessage)
          .doc(selectedMsg[0]).delete();
    } else {
      for (var element in msgs) {
        if (kDebugMode) {
          print('element is $element');
        }
        await firebaseFireStore.collection(kRoomsCollections)
            .doc(roomId).collection(kMessage)
            .doc(element).delete();
      }
      // for(var i = selectedMsg.length; i>= 0 ; i++){
      //   await firebaseFireStore.collection(kRoomsCollections)
      //       .doc(roomId).collection(kMessage)
      //       .doc(i.msgs.toString()).delete();
      // }
    }
  }

  Future editProfile(String name, String about,) async
  {
    await firebaseFireStore.collection(kUsersCollections)
        .doc(myId).update({
      kName: name,
      kAbout: about,
    });
    //await user1!.updateDisplayName(name);
    //await user1.verifyBeforeUpdateEmail(email);

    // await FirebaseAuth.instance
    //     .authStateChanges()
    //     .listen((User? user) {
    //   user!.updateDisplayName(name);
    // });
  }

}
