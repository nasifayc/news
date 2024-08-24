import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/app_navigator.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/search/search_cubit.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/screens/layouts/search_page.dart';
import 'package:news_app/screens/layouts/sign_in_screen.dart';
import 'package:news_app/screens/layouts/sign_up_screen.dart';
import 'package:news_app/services/authentication_services.dart';
import 'package:news_app/services/news_services.dart';

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
        _emitUnAuthenticated(e.toString());
      }
    }
  }

  void _emitAuthenticated(UserModel user) {
    context.read<AuthenticationCubit>().emitAuthenticated(user);
  }

  void _emitUnAuthenticated(String e) {
    context.read<AuthenticationCubit>().emitUnauthenticated(e);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit(newsServices: NewsServices()),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        )
      ],
      child: MaterialApp(
        title: 'News',
        theme: LightModeTheme().themeData,
        routes: {
          '/sign_in': (context) => const SignInScreen(),
          '/sign_up': (context) => const SignUpScreen(),
          '/search': (context) => const SearchPage(),
        },
        home: const AppNavigator(),
      ),
    );
  }
}
