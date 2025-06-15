import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:winkr/commons/widgets/filter_chip/filter_chip.dart';
import 'package:winkr/features/ai_response/data/response_service.dart';
import 'package:winkr/features/ai_response/data/response_use_case.dart';
import 'package:winkr/features/ai_response/domain/response_model.dart';

import '../../../../commons/widgets/textfields/regular_textfield.dart';
import '../../data/send_message_use_case.dart';
import '../../domain/models/message_model.dart';
import 'chat_provider.dart';

class ChatBox extends ConsumerWidget {
  const ChatBox({
    super.key,
    required this.messageController,
    required this.conversationId,

    required this.sendMessage,
  });

  final TextEditingController messageController;
  final String conversationId;

  final SendMessageUseCase sendMessage;

  @override
  Widget build(BuildContext contex, WidgetRef ref) {
    final chatUploading = ref.watch(chatLoading);
    final getResponse = ResponseUseCase(ResponseService());
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 10),
      width: double.infinity,
      child: Column(
        children: [
          RegularTextField(
            controller: messageController,

            hintText: "Chat with Winkr",
            withTitle: false,
            withSuffixIcon: true,
            onSuffixIconPressed: chatUploading
                ? null
                : () async {
                    if (messageController.text.isEmpty) {
                      return;
                    }
                    developer.log(
                      "Platform: ${ref.read(selectedFilterProvider)}",
                    );
                    final chatLoad = ref.read(chatLoading.notifier);
                    final winkrLoad = ref.read(winkrThinking.notifier);
                    chatLoad.update((state) => true);

                    developer.log("Message Loading");
                    final MessageModel message = MessageModel(
                      platform: ref.read(selectedFilterProvider),
                      messageId: "${Timestamp.now().millisecondsSinceEpoch}",
                      message: messageController.text,
                      timestamp: Timestamp.now(),
                      senderId: "Tristan",
                      conversationId: conversationId,
                    );

                    await sendMessage.execute(message);
                    messageController.clear();
                    winkrLoad.update((state) => true);
                    developer.log("Winkr Loading");
                    final Response? responseMessage = await getResponse.execute(
                      messageController.text,
                    );
                    final Response response = Response(
                      intro: responseMessage!.intro,
                      bioOne: responseMessage.bioOne,
                      bioTwo: responseMessage.bioTwo,
                      bioThree: responseMessage.bioThree,
                    );
                    final MessageModel winkrMessage = MessageModel(
                      platform: ref.read(selectedFilterProvider),
                      messageId: "${Timestamp.now().millisecondsSinceEpoch}",
                      timestamp: Timestamp.now(),
                      senderId: "Winkr AI",
                      conversationId: conversationId,
                      response: response,
                    );
                    messageController.clear();

                    await sendMessage.execute(winkrMessage);
                    chatLoad.update((state) => false);
                    developer.log("Chat Upload Stop Loading");
                    winkrLoad.update((state) => false);
                    developer.log("Winkr Upload Stop Loading");
                  },
          ),
        ],
      ),
    );
  }
}
