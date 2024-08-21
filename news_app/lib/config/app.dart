import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/screens/layouts/sign_in_screen.dart';
import 'package:news_app/screens/onboarding_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: LightModeTheme().themeData,
      routes: {
        '/sign_in': (context) => const SignInScreen(),
      },
      home: const OnboardingScreen(),
    );
  }
}
