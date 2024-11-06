import 'package:air_ticket/theme/app_colors.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  static final _basicTheme = AppColors();

  ThemeData get theme => Theme.of(this);
  AppColors get color => _basicTheme;
}

extension ThemeDataX on ThemeData {
  TextStyle get title1 => const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
  TextStyle get title2 => const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  TextStyle get title3 => const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  TextStyle get title4 => const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  TextStyle get text1 => const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  TextStyle get text2 => const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  TextStyle get buttonText => const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  TextStyle get tabText => const TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}
