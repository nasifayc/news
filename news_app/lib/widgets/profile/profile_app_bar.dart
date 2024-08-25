import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);

    void showLogoutDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Confirm Logout",
              style: theme.typography.titleMedium2,
            ),
            content: Text("Are you sure you want to log out?",
                style: theme.typography.titleSmall2),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel", style: theme.typography.titleSmall),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text("Logout", style: theme.typography.titleSmall),
                onPressed: () {
                  context.read<AuthenticationCubit>().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/onboarding',
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: theme.typography.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return Text(
                      'the${state.user.username.toLowerCase()}_news',
                      style: theme.typography.headlineMedium2,
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: showLogoutDialog,
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      fontSize: 18,
                      color: theme.error,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: theme.primary, width: 1)),
                child: Center(
                  child: Image.asset(
                    'assets/images/setting-2.png',
                    height: 24,
                    width: 24,
                    color: theme.info,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
