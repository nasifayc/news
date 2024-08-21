import 'package:flutter/material.dart';
import 'package:news_app/widgets/onboarding/carousel_card.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CarouselCard(),
        ],
      ),
    );
  }
}
