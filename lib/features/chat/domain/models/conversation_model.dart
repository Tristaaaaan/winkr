import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String? conversationId;
  final Timestamp createdAt;
  final String platform;

  ConversationModel({
    required this.conversationId,
    required this.createdAt,
    required this.platform,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conversationId': conversationId,
      'createdAt': createdAt,
      'platform': platform,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      conversationId: map['conversationId'] as String,
      createdAt: map['createdAt'] as Timestamp,
      platform: map['platform'] as String,
    );
  }
}
