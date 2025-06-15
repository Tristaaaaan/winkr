import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winkr/features/chat/domain/models/message_model.dart';

import '../domain/chat_repository.dart';

class ChatService implements ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<String> sendMessage(MessageModel messageModel) async {
    final docRef = await _firestore
        .collection('conversation')
        .doc(messageModel.conversationId)
        .collection('messages')
        .add(messageModel.toMap());

    return docRef.id;
  }

  @override
  Stream<List<MessageModel>> streamMessages(String conversationid) {
    return _firestore
        .collection('conversation')
        .doc(conversationid)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(15)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.data()))
              .toList();
        });
  }
}
