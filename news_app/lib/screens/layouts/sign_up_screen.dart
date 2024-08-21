import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/widgets/authentication/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
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
              const SignUpForm()
            ],
          ),
        ),
      ),
    ));
  }
}
