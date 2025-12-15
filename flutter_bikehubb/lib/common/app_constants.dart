import 'package:flutter/material.dart';

/// Constantes de cores do aplicativo BikeHubb
class AppColors {
  AppColors._(); // Construtor privado para evitar instanciação

  // Cores principais
  static const Color primaryGreen = Color(0xFF22c55e);
  static const Color darkGreen = Color.fromARGB(255, 24, 92, 62);
  static const Color shadowGreen = Color.fromARGB(255, 27, 145, 63);

  // Cores de background
  static const Color backgroundColor = Color(0xFF242E41);
  static const Color appBarColor = Color.fromRGBO(35, 39, 42, 1);
  static const Color darkBackground = Color(0xFF0f1419);
  static const Color inputFillColor = Color(0xFF1c222e);
  static const Color cardBackground = Color(0xFF1c222e);

  // Cores de texto
  static const Color textWhite = Colors.white;
  static const Color textWhite70 = Colors.white70;
  static const Color textWhite60 = Colors.white60;
  static const Color textWhite54 = Colors.white54;

  // Cores de borda
  static const Color borderGreen = primaryGreen;
  static const Color dividerColor = Colors.white24;
}

/// Constantes de dimensões e espaçamentos
class AppDimensions {
  AppDimensions._(); // Construtor privado

  // Border Radius
  static const double borderRadius = 12.0;
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusLarge = 16.0;

  // Padding e Margins
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  static const double paddingXXLarge = 40.0;

  // Widths e Heights
  static const double maxFormWidth = 400.0;
  static const double buttonHeight = 50.0;
  static const double inputHeight = 56.0;

  // Icon Sizes
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 40.0;

  // Logo Sizes
  static const double logoSizeSmall = 32.0;
  static const double logoSizeMedium = 40.0;
  static const double logoSizeLarge = 80.0;

  // Elevations
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;

  // Border Widths
  static const double borderWidthThin = 1.0;
  static const double borderWidthMedium = 2.0;
  static const double borderWidthThick = 3.0;
}

/// Constantes de texto e estilos
class AppTextStyles {
  AppTextStyles._(); // Construtor privado

  // Font Family
  static const String fontFamily = 'Segoe UI, Roboto';

  // Títulos
  static const TextStyle titleLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: AppColors.textWhite,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.primaryGreen,
    fontFamily: fontFamily,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );

  // Subtítulos
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textWhite,
  );

  static const TextStyle subtitleGreen = TextStyle(
    fontSize: 14,
    color: AppColors.primaryGreen,
    fontWeight: FontWeight.w600,
  );

  // Botões
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  // Input
  static const TextStyle inputLabel = TextStyle(color: AppColors.textWhite);

  static const TextStyle inputText = TextStyle(color: AppColors.textWhite);

  static const TextStyle inputHint = TextStyle(color: AppColors.textWhite54);

  // Body
  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: AppColors.textWhite70,
  );

  static const TextStyle bodyTextSmall = TextStyle(
    fontSize: 12,
    color: AppColors.textWhite60,
  );
}

/// Constantes de duração de animações
class AppDurations {
  AppDurations._(); // Construtor privado

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration slow = Duration(seconds: 1);
  static const Duration xSlow = Duration(seconds: 2);
}

/// Constantes de assets (imagens, ícones, etc)
class AppAssets {
  AppAssets._(); // Construtor privado

  static const String logo = 'assets/images/bikehubb_logo.png';
}
