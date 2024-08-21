import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/widgets/sign_in/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

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
    ));
  }
}
