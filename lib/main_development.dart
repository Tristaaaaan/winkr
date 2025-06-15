import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:winkr/core/approutes/app_routes.dart';
import 'package:winkr/firebase/dev/firebase_options.dart';

import 'config/app_config.dart';
import 'config/app_environments.dart';
import 'core/appthemes/app_themes.dart';

void main() async {
  AppConfig.setEnvironment(Flavors.development);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "winkr-dev",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider.notifier).currentTheme;

    return MaterialApp.router(
      theme: theme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
