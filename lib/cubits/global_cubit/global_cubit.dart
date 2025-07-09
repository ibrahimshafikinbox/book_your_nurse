import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../const/chat_const.dart';
import '../../presentation/profile_user/model/user_model.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<bool> {
  GlobalCubit() : super(false);
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  late final String myUserId;
  late  UserModel userModel;
  late StreamSubscription _controller;

  void getUserData() {
    try {
      myUserId = _firebaseAuth.currentUser!.uid;
      
      // First try to get data from nurse collection
      _controller = _firebaseFirestore
          .collection('nurse')
          .doc(myUserId)
          .snapshots()
          .listen((event) {
        if (event.data() != null) {
          // User is a nurse
          userModel = UserModel.fromJson(event.data()!);
          emit(true); // true means nurse
        } else {
          // If not found in nurse, try users collection
          _firebaseFirestore
              .collection(kUsersCollections)
              .doc(myUserId)
              .snapshots()
              .listen((userEvent) {
            if (userEvent.data() != null) {
              userModel = UserModel.fromJson(userEvent.data()!);
              if (userModel.userType == 'nurse') {
                emit(true); // nurse
              } else {
                emit(false); // user
              }
            }
          });
        }
      });
    } on Exception {
      // If nurse collection fails, try users collection
      try {
        myUserId = _firebaseAuth.currentUser!.uid;
        _controller = _firebaseFirestore
            .collection(kUsersCollections)
            .doc(myUserId)
            .snapshots()
            .listen((event) {
          if (event.data() != null) {
            userModel = UserModel.fromJson(event.data()!);
            if (userModel.userType == 'nurse') {
              emit(true); // nurse
            } else {
              emit(false); // user
            }
          }
        });
      } on Exception {
        // Handle any remaining errors
      }
    }
  }

  @override
  Future<void> close() {
    _controller.cancel();
    return super.close();
  }
}
