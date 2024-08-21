import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  const PrimaryButton(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 63.91,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: theme.secondary, borderRadius: BorderRadius.circular(13.7)),
        child: Center(child: child),
      ),
    );
  }
}
