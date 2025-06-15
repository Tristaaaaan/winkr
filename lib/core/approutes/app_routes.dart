import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:winkr/features/chat/presentation/screen/chat_screen.dart';
import 'package:winkr/features/home/presentation/screen/home_screen.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',

      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: '/chat',
      builder: (BuildContext context, GoRouterState state) {
        final conversationId =
            state.uri.queryParameters['conversationId'] ?? '';

        return ChatScreen(conversationId: conversationId.toString());
      },
    ),
  ],
);
