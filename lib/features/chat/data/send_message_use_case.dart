import '../domain/chat_repository.dart';
import '../domain/models/message_model.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> execute(MessageModel messageModel) async {
    await repository.sendMessage(messageModel);
  }
}
