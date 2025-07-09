import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/const/chat_const.dart';
import '../../presentation/profile_user/model/user_model.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  static ChatCubit get(context) => BlocProvider.of<ChatCubit>(context);

  TextEditingController sendController = TextEditingController();

  final scrollController = ScrollController();

  UserModel? userModel;

  var users =
  FirebaseFirestore.instance.collection(kUsersCollections);
  var rooms =
  FirebaseFirestore.instance.collection(kRoomsCollections);

  void getRooms()
  {

  }
}
