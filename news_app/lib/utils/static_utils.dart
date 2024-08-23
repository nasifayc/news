import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:news_app/config/theme/app_theme.dart';

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
}
