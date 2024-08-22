import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back, ${state.user.username}!",
                maxLines: 2,
                style: theme.typography.headlineMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Discover a world of news that matters to you",
                maxLines: 2,
                style: theme.typography.headlineMedium2,
              ),
            ],
          );
        }

        return Text(
          "Login to Explore More",
          style: theme.typography.headlineLarge,
        );
      },
    );
  }
}
