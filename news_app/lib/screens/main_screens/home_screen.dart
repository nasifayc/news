import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/screens/onboarding_screen.dart';
import 'package:news_app/widgets/common/primary_button.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is AuthenticationInitial) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome Home ${widget.user.username}',
                style: theme.typography.headlineMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().signOut();
                },
                child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    if (state is Authenticating) {
                      return CircularProgressIndicator(
                        color: theme.primary,
                      );
                    }
                    return Text(
                      "Log Out",
                      style: theme.typography.labelMedium,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
