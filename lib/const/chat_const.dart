

import 'package:flutter/material.dart';

import '../presentation/profile_user/model/user_model.dart';

const kMessageCollections = 'messages';
const kUsersCollections = 'users';
const kRoomsCollections = 'rooms';
const kId = 'id';
const kName = 'name';
const kEmail = 'email';
const kImage = 'image';
const kToken = 'token';
const kMembers = 'members';
const kMessage = 'messages';
const kLastMessage = 'lastMessage';
const kLastMessageTime = 'lastMessageTime';
const kCreateAt = 'createAt';
const kCreatedAt = 'createdAt';
const kOnline = 'online';
const kLastActivated = 'lastActivated';
const kAbout = 'about';
const kToId = 'toId';
const kFromId = 'fromId';
const kType = 'type';
const kRead = 'read';
const kPhone = 'PhoneNumber';
const kIsDoctor = 'isDoctor';
// to
UserModel? userModel;
// me
UserModel? userModel1;
String? userId;
final TextEditingController searchController = TextEditingController();
List<String> selectedMsg = [];
List<String> copyMsg = [];
String? urlImage;
