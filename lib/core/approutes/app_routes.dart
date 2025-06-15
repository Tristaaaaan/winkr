import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:winkr/features/chat/presentation/widgets/chatcontainer.dart';
import 'package:winkr/features/home/presentation/screen/home_screen.dart';
import 'package:winkr/features/subscribe/presentation/screen/subscribe_screen.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },

      routes: <RouteBase>[
        GoRoute(
          path: 'chat',
          builder: (BuildContext context, GoRouterState state) {
            final conversationId =
                state.uri.queryParameters['conversationId'] ?? '';

            return ChatScreen(conversationId: conversationId);
          },
        ),

        GoRoute(
          path: 'subscribe',
          builder: (BuildContext context, GoRouterState state) {
            return SubscriptionScreen();
          },
        ),
      ],
    ),
  ],
);
