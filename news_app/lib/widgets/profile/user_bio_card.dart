import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/utils/static_utils.dart';

class UserBioCard extends StatelessWidget {
  const UserBioCard({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          UserModel user = state.user;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${user.username} News',
                    style: theme.typography.headlineMedium,
                    maxLines: 2,
                  ),
                  user.isVerfied
                      ? StaticUtils.getBlueTick(theme)
                      : const SizedBox.shrink()
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.bio == null
                    ? 'This is ${user.username} News, Enjoy!'
                    : user.bio!,
                style: theme.typography.titleSmall2,
                maxLines: 4,
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
