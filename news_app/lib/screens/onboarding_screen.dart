import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/widgets/common/primary_button.dart';
import 'package:news_app/widgets/onboarding/carousel_card.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CarouselCard(),
          Text(
            "First to Know",
            style: theme.typography.headlineMedium,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                "All news in one place, be the first to know last news",
                style: theme.typography.headlineSmall,
              ),
            ),
          ),
          PrimaryButton(
            onPressed: null,
            child: Text(
              'Get Started',
              style: theme.typography.labelLarge,
            ),
          )
        ],
      ),
    );
  }
}
