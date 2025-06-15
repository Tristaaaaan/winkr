import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/chat_service.dart';
import '../../domain/chat_repository.dart';
import '../../domain/models/message_model.dart';

final chatServiceProvider = Provider<ChatRepository>((ref) {
  return ChatService();
});

final messageStreamProvider = StreamProvider.family<List<MessageModel>, String>(
  (ref, conversationId) {
    final chatService = ref.watch(chatServiceProvider);
    return chatService.streamMessages(conversationId);
  },
);

final winkrThinking = StateProvider<bool>((ref) {
  return false;
});

final chatLoading = StateProvider<bool>((ref) {
  return false;
});

final showBiosProvider = StateProvider<bool>((ref) {
  return false;
});
