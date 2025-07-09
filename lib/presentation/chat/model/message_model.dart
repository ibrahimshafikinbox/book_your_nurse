

import '../../../const/chat_const.dart';

class MessageModel {
  final String message;
  final String id;
  final String name;
  final String time;
  final String online;
  final String lastActivated;
  final String email;
  MessageModel(
      this.message,
      this.id,
      this.time,
      this.online,
      this.lastActivated,
      this.email,
      this.name,
      );

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      jsonData[kMessage],
      jsonData[kId],
      jsonData[kName],
      jsonData[kCreatedAt],
      jsonData[kOnline],
      jsonData[kLastActivated],
      jsonData[kEmail],
    );
  }
}
