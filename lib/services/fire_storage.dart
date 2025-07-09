//
//
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medical_app/const/chat_const.dart';
// import 'package:medical_app/services/fire_chat.dart';
//
// class FireStorage{
//   final FirebaseStorage fireStorage = FirebaseStorage.instance;
//
//   Future updateProfileImage({
//     required File file,
//   }) async
//   {
//     String uId = FirebaseAuth.instance.currentUser!.uid;
//     String ext = file.path.split('.').last;
//     final ref = fireStorage.ref().child(
//         "profile/$uId/${DateTime.now().millisecondsSinceEpoch}.$ext");
//     await ref.getDownloadURL();
//     String imageUrl = await ref.getDownloadURL();
//     await FirebaseFirestore.instance.collection(kUsersCollections)
//     .doc(uId).update({kImage : imageUrl});
//   }
//
//   Future<String> uploadImage(String path, XFile image) async
//   {
//     // try{
//     //   final ref = FirebaseStorage.instance.ref(path)
//     //       .child(image.name);
//     //   await ref.putFile(File(path));
//     //   final String imageUrl = await ref.getDownloadURL();
//     //   return imageUrl;
//     // } on FirebaseException catch (e) {
//     //    print(e.toString());
//     // } on FormatException catch (_){
//     //   print(_.toString());
//     // } on PlatformException catch (e){
//     //   print(e.toString());
//     // } catch(e) {
//     //   print(e.toString());
//     // }
//       final ref = FirebaseStorage.instance.ref(path)
//           .child(image.name);
//       await ref.putFile(File(path));
//       final String imageUrl = await ref.getDownloadURL();
//       return imageUrl;
//   }
// }