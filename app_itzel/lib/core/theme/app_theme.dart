import 'package:flutter/material.dart';

class AppTheme {
  /// Color principal terracota (sólido, sin degradado).
  static const terracota = Color(0xFFC0623F);
  static const terracotaOscuro = Color(0xFF9C4A2C);
  static const fondo = Color(0xFFFBF5F1);

  static ThemeData _base(Brightness b) {
    final esClaro = b == Brightness.light;
    final scheme = ColorScheme.fromSeed(
      seedColor: terracota,
      brightness: b,
      primary: esClaro ? terracota : const Color(0xFFE59A7B),
    );
    final radio = BorderRadius.circular(16);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: esClaro ? fondo : const Color(0xFF1E1714),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: terracota,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: esClaro ? Colors.white : const Color(0xFF2B201C),
        shape: RoundedRectangleBorder(
          borderRadius: radio,
          side: BorderSide(color: scheme.primary.withValues(alpha: 0.12)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: esClaro ? Colors.white : const Color(0xFF2B201C),
        border: OutlineInputBorder(borderRadius: radio),
        enabledBorder: OutlineInputBorder(
          borderRadius: radio,
          borderSide: BorderSide(color: scheme.primary.withValues(alpha: 0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radio,
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: radio),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: radio),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: terracota,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: radio),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  static final light = _base(Brightness.light);
  static final dark = _base(Brightness.dark);
}

/// AppBar con fondo terracota sólido.
class AppBarRosa extends StatelessWidget implements PreferredSizeWidget {
  const AppBarRosa({super.key, required this.titulo, this.actions});
  final String titulo;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(titulo),
        actions: actions,
      );
}
