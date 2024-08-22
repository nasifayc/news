import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/widgets/common/custome_form_fields.dart';
import 'package:news_app/widgets/common/primary_button.dart';
import 'package:news_app/widgets/common/secondary_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
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
    final AppTheme theme = AppTheme.of(context);
    final CustomFormComponents formComponents =
        CustomFormComponents(context: context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          formComponents.buildNormalTextField(
            _emailController,
            Text(
              "Email",
              style: theme.typography.labelLarge2,
            ),
            prefixIcon: Image.asset(
              "assets/images/sms.png",
              color: theme.accent2,
              height: 22,
              width: 22,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required!';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          formComponents.buildPasswordField(
            _passwordController,
            Text(
              "Password",
              style: theme.typography.labelLarge2,
            ),
            prefixIcon: Image.asset(
              "assets/images/lock.png",
              color: theme.accent2,
              height: 22,
              width: 22,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Passwors is required!';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: theme.typography.labelMedium2,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          PrimaryButton(onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              context.read<AuthenticationCubit>().signInWithEmailAndPassword(
                  _emailController.text.trim(),
                  _passwordController.text.trim());
            }
          }, child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              if (state is Authenticating) {
                return CircularProgressIndicator(
                  color: theme.primary,
                );
              }
              return Text(
                'Sign In',
                style: theme.typography.labelLarge,
              );
            },
          )),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: theme.accent2,
                height: 1,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              Text(
                'or',
                style: theme.typography.labelMedium2,
              ),
              Container(
                color: theme.accent2,
                height: 1,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SecondaryButton(
            onPressed: () {
              context.read<AuthenticationCubit>().signInWithGoogle();
            },
            prefix: Image.asset(
              "assets/images/google.png",
              height: 20,
              width: 20,
            ),
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticatingGoogle) {
                  return CircularProgressIndicator(
                    color: theme.secondary,
                  );
                }
                return Text(
                  'Sign in with Google',
                  style: theme.typography.displaySmall,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SecondaryButton(
            onPressed: () {
              context.read<AuthenticationCubit>().signInWithFacebook();
            },
            prefix: Image.asset(
              "assets/images/facebook.png",
              height: 20,
              width: 20,
            ),
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticatingFacebook) {
                  return CircularProgressIndicator(
                    color: theme.secondary,
                  );
                }
                return Text(
                  'Sign in with Facebook',
                  style: theme.typography.displaySmall,
                );
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: theme.typography.labelMedium2,
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/sign_up');
                },
                child: Text(
                  "Sign Up",
                  style: theme.typography.headlineSmall,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
