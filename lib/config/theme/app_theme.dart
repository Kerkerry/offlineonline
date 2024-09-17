import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  // Light theme
  static ThemeData lightTheme = FlexThemeData.light(
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: false,
    useMaterial3: true,
    scheme: FlexScheme.sanJuanBlue,
    surfaceTint: Colors.transparent,
    textTheme: const TextTheme(),
    fontFamily: GoogleFonts.rubik().fontFamily,
    dialogBackground: Colors.grey.shade100,
    subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true),
  );
  // Dark theme
  static ThemeData darkTheme = FlexThemeData.light(
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: false,
    useMaterial3: true,
    surfaceTint: Colors.transparent,
    scheme: FlexScheme.blueM3,
    fontFamily: GoogleFonts.rubik().fontFamily,
    dialogBackground: Colors.grey.shade900,
    tabBarStyle: FlexTabBarStyle.forBackground,
    subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true),
  );
}
