import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/widgets/common/custome_form_fields.dart';
import 'package:news_app/widgets/common/primary_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            _usernameController,
            Text(
              "Username",
              style: theme.typography.labelLarge2,
            ),
            prefixIcon: Image.asset(
              "assets/images/user.png",
              color: theme.accent2,
              height: 22,
              width: 22,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required!';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
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
          const SizedBox(height: 15),
          formComponents.buildPasswordField(
            _confirmPasswordController,
            Text(
              "Confirm Password",
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
                return 'Confirm Password!';
              }

              if (value != _passwordController.text.trim()) {
                return 'Passwords do not match!';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              context.read<AuthenticationCubit>().signUpWithEmailAndPassword(
                  _usernameController.text.trim(),
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
                'Sign Up',
                style: theme.typography.labelLarge,
              );
            },
          )),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Have an account?",
                style: theme.typography.labelMedium2,
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/sign_in');
                },
                child: Text(
                  "Sign In",
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
