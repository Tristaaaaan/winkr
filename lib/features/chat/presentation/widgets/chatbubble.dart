import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:winkr/features/chat/presentation/widgets/chat_provider.dart';

import '../../../../commons/widgets/snackbars/information_snackbar.dart';
import '../../domain/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: message.senderId != "Winkr AI" ? 8 : 4,
      ),
      child: message.senderId != "Winkr AI"
          ? Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 300),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Text(
                        "${message.message}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ResponseContainer(message: message),
    );
  }
}

class ResponseContainer extends ConsumerWidget {
  const ResponseContainer({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBios = ref.watch(showBiosProvider);
    final winkrLoad = ref.watch(winkrThinking);
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: showBios
            ? () {}
            : () {
                showModalBottomSheet(
                  showDragHandle: true,
                  context: context,
                  builder: (context) => SizedBox(
                    width: double.infinity,
                    height: 380,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          "Upgrade to Winkr+",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 15),
                        Offers(
                          icon: Icons.check_circle_outline,
                          title: "Unlimited Copies",
                          description: "Enjoy unlimited copies for your bios",
                        ),
                        Offers(
                          icon: Icons.party_mode,
                          title: "Unlimited Requests",
                          description: "Send unlimited requests to Winkr",
                        ),
                        Offers(
                          icon: Icons.support_agent_rounded,
                          title: "Priority Support",
                          description:
                              "Get help faster with direct access to support",
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: winkrLoad
                              ? null
                              : () async {
                                  final winkrLoading = ref.read(
                                    winkrThinking.notifier,
                                  );
                                  winkrLoading.update((state) => true);
                                  await Future.delayed(
                                    const Duration(seconds: 5),
                                  );
                                  ref.read(showBiosProvider.notifier).state =
                                      true;
                                  winkrLoading.update((state) => false);

                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                },
                          child: SubcribeButton(),
                        ),
                      ],
                    ),
                  ),
                );
              },
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  message.response!.intro,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  softWrap: true,
                ),
              ),
              ResponseTile(bio: message.response!.bioOne),
              ResponseTile(bio: message.response!.bioTwo),
              ResponseTile(bio: message.response!.bioThree),
              if (!showBios)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "To view, upgrade to Winkr+",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubcribeButton extends ConsumerWidget {
  const SubcribeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winkrLoad = ref.watch(winkrThinking);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: winkrLoad
          ? Center(child: const CircularProgressIndicator(color: Colors.white))
          : Text(
              "Subscribe now",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
    );
  }
}

class ResponseTile extends ConsumerWidget {
  const ResponseTile({super.key, required this.bio});

  final String bio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBios = ref.watch(showBiosProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ImageFiltered(
        imageFilter: showBios
            ? ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0)
            : ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              Text(
                bio,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
                softWrap: true,
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: bio));
                    informationSnackBar(
                      context,
                      Icons.copy_all,
                      "Bio has been copied",
                    );
                  },
                  child: Icon(
                    Icons.copy_all_outlined,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Offers extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const Offers({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
            ),
            child: Icon(
              icon,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
