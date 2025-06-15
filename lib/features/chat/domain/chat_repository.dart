import 'models/message_model.dart';

abstract class ChatRepository {
  Future<String> sendMessage(MessageModel messageModel);

  Stream<List<MessageModel>> streamMessages(String conversationId);
}
