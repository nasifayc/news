import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';

class CarouselCard extends StatefulWidget {
  const CarouselCard({super.key});

  @override
  State<CarouselCard> createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/carousel1.jpg",
      "assets/images/carousel2.jpg",
      "assets/images/carousel3.jpg"
    ];

    AppTheme theme = AppTheme.of(context);

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.7),
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 1.1,
            pauseAutoPlayOnTouch: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 2),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) => Container(),
                options: CarouselOptions(
                  initialPage: entry.key,
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentIndex == entry.key ? 12.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: _currentIndex == entry.key
                      ? theme.secondary
                      : theme.accent1,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
