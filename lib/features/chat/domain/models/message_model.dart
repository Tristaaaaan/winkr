import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../ai_response/domain/response_model.dart';

class MessageModel {
  final String messageId;
  final String? message;
  final Timestamp timestamp;
  final String conversationId;
  final String senderId;
  final Response? response;
  final String platform;

  MessageModel({
    required this.messageId,
    this.message,
    required this.timestamp,
    required this.conversationId,
    required this.senderId,
    this.response,
    required this.platform,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'message': message,
      'timestamp': timestamp,

      'senderId': senderId,
      'conversationId': conversationId,
      'response': response?.toMap(),
      'platform': platform,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] ?? '',
      message: map['message'] ?? '',
      conversationId: map['conversationId'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      platform: map['platform'] ?? '',
      senderId: map['senderId'] ?? '',
      response: map['response'] != null
          ? Response.fromMap(map['response'])
          : null,
    );
  }
  factory MessageModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing data for messageId: ${doc.id}');
    }

    return MessageModel(
      messageId: data['messageId'] ?? doc.id,
      message: data['message'] ?? '',
      conversationId: data['conversationId'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      senderId: data['senderId'] ?? '',
      platform: data['platform'] ?? '',
      response: data['response'] != null
          ? Response.fromMap(data['response'])
          : null,
    );
  }
}
