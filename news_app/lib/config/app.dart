import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/app_navigator.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/screens/layouts/sign_in_screen.dart';
import 'package:news_app/screens/layouts/sign_up_screen.dart';
import 'package:news_app/services/authentication_services.dart';

class App extends StatefulWidget {
  final String? userId;
  const App({super.key, required this.userId});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _initilize();
  }

  void _initilize() async {
    if (widget.userId != null) {
      try {
        final AuthenticationServices auth = AuthenticationServices();
        UserModel? user = await auth.getUser(widget.userId!);
        _emitAuthenticated(user!);
      } catch (e) {
        _emitUnAuthenticated();
      }
    }
  }

  void _emitAuthenticated(UserModel user) {
    context.read<AuthenticationCubit>().emitAuthenticated(user);
  }

  void _emitUnAuthenticated() {
    context.read<AuthenticationCubit>().emitUnauthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: LightModeTheme().themeData,
      routes: {
        '/sign_in': (context) => const SignInScreen(),
        '/sign_up': (context) => const SignUpScreen(),
      },
      home: const AppNavigator(),
    );
  }
}
