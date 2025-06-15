import 'package:cloud_firestore/cloud_firestore.dart';

class StudioChatModel {
  final String? conversationId;

  final String lastMessage;
  final String lastMessageSenderId;
  final Timestamp lastMessageTimeSent;
  final String lastMessageType;
  final String? lastMessageId;

  StudioChatModel({
    required this.conversationId,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.lastMessageTimeSent,
    required this.lastMessageType,
    this.lastMessageId,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studioId': conversationId,
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageTimeSent': lastMessageTimeSent,
      'lastMessageType': lastMessageType,
      'lastMessageId': lastMessageId,
    };
  }

  factory StudioChatModel.fromMap(Map<String, dynamic> map) {
    return StudioChatModel(
      conversationId: map['conversationId'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageSenderId: map['lastMessageSenderId'] as String,
      lastMessageTimeSent: map['lastMessageTimeSent'] as Timestamp,
      lastMessageType: map['lastMessageType'] as String,
      lastMessageId: map['lastMessageId'] as String?,
    );
  }
}
