import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/screens/main_screens/home_screen.dart';
import 'package:news_app/screens/onboarding_screen.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is Authenticated) {}
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return HomeScreen(user: state.user);
        }
        return const OnboardingScreen();
      },
    );
  }
}
