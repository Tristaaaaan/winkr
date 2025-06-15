import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:winkr/features/chat/presentation/widgets/chat_provider.dart';

import 'chatbubble.dart';

class ChatContainer extends ConsumerWidget {
  final String conversationId;

  const ChatContainer({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(messageStreamProvider(conversationId));

    return Expanded(
      child: conversations.when(
        data: (messages) {
          return messages.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "There are no messages yet.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  reverse: true,

                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ChatBubble(
                      message: message,
                      key: ValueKey(message.messageId),
                    );
                  },
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
