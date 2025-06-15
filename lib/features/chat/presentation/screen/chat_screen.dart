import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/chat/application/send_message_use_case.dart';
import 'package:tugtugan/features/chat/data/chat_service.dart';
import 'package:tugtugan/features/chat/presentation/chat_provider.dart';
import 'package:tugtugan/features/chat/presentation/widget/chatbox.dart';
import 'package:tugtugan/features/chat/presentation/widget/chatcontainer.dart';

import '../../data/chat_service.dart';
import '../../data/send_message_use_case.dart';
import '../widgets/chatbox.dart';
import '../widgets/chatcontainer.dart';

class ChatPage extends ConsumerWidget {
  final String studioId;
  const ChatPage({super.key, required this.studioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController messageController = TextEditingController();

    final sendMessage = SendMessageUseCase(ChatService());

    return Scaffold(
      body: Column(
        children: [
          ChatScreen(conversationId: studioId),
          ChatBox(
            messageController: messageController,
            studioId: studioId,

            sendMessage: sendMessage,
          ),
        ],
      ),
    );
  }
}
