import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class StaticUtils {
  static String defaultImageUrl =
      "https://media.istockphoto.com/id/1466050714/photo/social-media-marketing-digitally-generated-image-engagement.webp?b=1&s=612x612&w=0&k=20&c=h0t079gHjPHqsjJDYosXkyCOhCxYU1hTKul_6JIGku8=";
  static String healthImageUrl1 =
      "https://images.unsplash.com/photo-1507413245164-6160d8298b31?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  static String healthImageUrl2 =
      "https://images.unsplash.com/photo-1535127022272-dbe7ee35cf33?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8c2NpZW5jZXxlbnwwfHwwfHx8MA%3D%3D";
  static String healthImageUrl3 =
      "https://images.unsplash.com/photo-1524683745036-b46f52b8505a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHNjaWVuY2V8ZW58MHx8MHx8fDA%3D";
  static String businessImageUrl1 =
      "https://plus.unsplash.com/premium_photo-1661764256397-af154e87b1b3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8YnVzaW5lc3N8ZW58MHx8MHx8fDA%3D";
  static String businessImageUrl2 =
      "https://images.unsplash.com/photo-1664575599736-c5197c684128?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGJ1c2luZXNzfGVufDB8fDB8fHww";
  static String businessImageUrl3 =
      "https://plus.unsplash.com/premium_photo-1661277816311-28cced31f998?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGJ1c2luZXNzfGVufDB8fDB8fHww";
  static String envinmentImageUrl1 =
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8d29ybGR8ZW58MHx8MHx8fDA%3D";
  static String envinmentImageUrl2 =
      "https://images.unsplash.com/photo-1613333151146-7634fe2c5994?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHdvcmxkfGVufDB8fDB8fHww";
  static String envinmentImageUrl3 =
      "https://images.unsplash.com/photo-1498831624351-bb3e382fe091?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHdvcmxkfGVufDB8fDB8fHww";
  static String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  static Image getBlueTick(AppTheme theme) {
    return Image.asset(
      'assets/images/verify.png',
      width: 18,
      height: 18,
      color: theme.secondaryText,
    );
  }

  static Shimmer getShimmerEffect(AppTheme theme, {double height = 100}) {
    return Shimmer.fromColors(
      baseColor: theme.primary,
      highlightColor: Colors.white,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
            color: theme.accent2, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
