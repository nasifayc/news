import 'package:flutter/material.dart';
import 'app_theme.dart';

abstract class AppTypography {
  String get fontFamily;
  TextStyle get displayLarge;
  TextStyle get displayMedium;
  TextStyle get displaySmall;
  TextStyle get headlineLarge;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;
  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get titleMedium2;
  TextStyle get titleSmall;
  TextStyle get labelLarge;
  TextStyle get labelMedium;
  TextStyle get labelSmall;
  TextStyle get bodyLargeWhite;
  TextStyle get bodyMediumWhite;
  TextStyle get bodySmallWhite;
}

class ThemeTypography extends AppTypography {
  ThemeTypography(this.theme);

  final AppTheme theme;

  @override
  String get fontFamily => "roboto";
  @override
  TextStyle get displayLarge => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 64,
      );
  @override
  TextStyle get displayMedium => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 44,
      );
  @override
  TextStyle get displaySmall => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36,
      );
  @override
  TextStyle get headlineLarge => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      );
  @override
  TextStyle get headlineMedium => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      );
  @override
  TextStyle get headlineSmall => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryText.withOpacity(0.7),
        fontWeight: FontWeight.normal,
        fontSize: 20,
      );
  @override
  TextStyle get titleLarge => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 22,
      );
  @override
  TextStyle get titleMedium => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 18,
      );
  @override
  TextStyle get titleMedium2 => TextStyle(
        fontFamily: fontFamily,
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 18,
      );
  @override
  TextStyle get titleSmall => TextStyle(
      fontFamily: fontFamily,
      color: theme.primaryText,
      fontWeight: FontWeight.normal,
      fontSize: 16,
      overflow: TextOverflow.ellipsis);
  @override
  TextStyle get labelLarge => TextStyle(
        fontFamily: fontFamily,
        color: theme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      );
  @override
  TextStyle get labelMedium => TextStyle(
      fontFamily: fontFamily,
      color: theme.primary,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      overflow: TextOverflow.ellipsis);

  @override
  TextStyle get labelSmall => TextStyle(
        fontFamily: fontFamily,
        color: theme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
  @override
  TextStyle get bodyLargeWhite => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryBtnText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  @override
  TextStyle get bodyMediumWhite => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryBtnText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  @override
  TextStyle get bodySmallWhite => TextStyle(
        fontFamily: fontFamily,
        color: theme.primaryBtnText,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );
}
