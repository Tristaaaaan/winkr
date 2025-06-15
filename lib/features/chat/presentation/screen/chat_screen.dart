import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/chat_service.dart';
import '../../data/send_message_use_case.dart';
import '../widgets/chatbox.dart';
import '../widgets/chatcontainer.dart';

class ChatScreen extends ConsumerWidget {
  final String conversationId;
  const ChatScreen({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController messageController = TextEditingController();

    final sendMessage = SendMessageUseCase(ChatService());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        appBar: AppBar(title: const Text("Winkr"), centerTitle: true),
        body: Column(
          children: [
            ChatContainer(conversationId: conversationId),
            ChatBox(
              messageController: messageController,
              conversationId: conversationId,
              sendMessage: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
