



import '../../../const/chat_const.dart';

class ChatModel {
  String? id;
  List? members;
  String? lastMessage;
  String? lastMessageTime;
  String? createdAt;

  ChatModel({
     this.id,
     this.members,
     this.lastMessage,
     this.lastMessageTime,
     this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json[kId] ?? '',
      members: json[kMembers] ?? [],
      lastMessage : json[kLastMessage],
      lastMessageTime : json[kLastMessageTime],
      createdAt : json[kCreateAt],
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      kId : id,
      kMembers : members,
      kLastMessage : lastMessage,
      kLastMessageTime : lastMessageTime,
      kCreateAt : createdAt,
    };
  }
}
