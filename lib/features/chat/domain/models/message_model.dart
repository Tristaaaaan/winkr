import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String message;
  final Timestamp timestamp;

  final String senderId;

  MessageModel({
    required this.messageId,
    required this.message,
    required this.timestamp,

    required this.senderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'message': message,
      'timestamp': timestamp,

      'senderId': senderId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),

      senderId: map['senderId'] ?? '',
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
      timestamp: data['timestamp'] ?? Timestamp.now(),
      senderId: data['senderId'] ?? '',
    );
  }
}
