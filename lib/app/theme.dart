import 'package:material_ui/material_ui.dart';

class RumahKuTheme {
  static const Color primarySeed = Color(0xFF0F766E); // Deep Teal
  static const Color secondarySeed = Color(0xFFD97706); // Warm Amber

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: primarySeed,
      secondary: secondarySeed,
      brightness: Brightness.light,
      surface: const Color(0xFFF8FAFC),
    );
    return _baseTheme(scheme, cardColor: Colors.white);
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: primarySeed,
      secondary: secondarySeed,
      brightness: Brightness.dark,
      surface: const Color(0xFF0F172A),
    );
    return _baseTheme(scheme, cardColor: const Color(0xFF1E293B));
  }

  static ThemeData _baseTheme(
    ColorScheme scheme, {
    required Color cardColor,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.65)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.8),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: scheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: cardColor,
        indicatorColor: scheme.primaryContainer,
        labelType: NavigationRailLabelType.all,
      ),
    );
  }
}
