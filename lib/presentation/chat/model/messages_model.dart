



import '../../../const/chat_const.dart';

class MessagesModel {
  String? id;
  String? toId;
  String? fromId;
  String? message;
  String? type;
  String? createdAt;
  String? read;
  MessagesModel({
    required this.id,
    required this.toId,
    required this.fromId,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.read,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      id: json[kId] ?? '',
      toId : json[kToId],
      fromId : json[kFromId],
      message : json[kMessage],
      type : json[kType],
      createdAt : json[kCreatedAt],
      read : json[kRead],
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      kId : id,
      kToId : toId,
      kFromId : fromId,
      kMessage : message,
      kType : type,
      kCreatedAt : createdAt,
      kRead : read,
    };
  }
}
