import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/screens/onboarding_screen.dart';
import 'package:news_app/widgets/common/primary_button.dart';
import 'package:news_app/widgets/profile/profile_app_bar.dart';
import 'package:news_app/widgets/profile/profile_card.dart';
import 'package:news_app/widgets/profile/profile_news.dart';
import 'package:news_app/widgets/profile/user_bio_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAppBar(),
              SizedBox(
                height: 20,
              ),
              ProfileCard(),
              SizedBox(
                height: 20,
              ),
              UserBioCard(),
              SizedBox(
                height: 20,
              ),
              ProfileNews(),
              SizedBox(
                height: 200,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
