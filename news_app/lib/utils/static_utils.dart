import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class StaticUtils {
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
      highlightColor: Colors.grey[100]!,
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
