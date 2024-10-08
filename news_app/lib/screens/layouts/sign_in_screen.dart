import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/screens/landing_page.dart';
import 'package:news_app/widgets/authentication/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Scaffold(
        body: BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: theme.info,
          ));
        } else if (state is Authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LandingPage()),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign In',
                  style: theme.typography.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Stay informed effortlessly. Sign in and explore a world of news',
                  style: theme.typography.headlineSmall2,
                ),
                const SizedBox(
                  height: 30,
                ),
                const SignInForm()
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
