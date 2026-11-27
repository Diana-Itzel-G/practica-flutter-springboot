import 'package:flutter/material.dart';

class AppTheme {
  /// Color principal azul petróleo.
  static const azulPetroleo = Color(0xFF0F4C5C);
  static const azulPetroleoOscuro = Color(0xFF0A3742);
  static const fondo = Color(0xFFFBF5F1);

  static ThemeData _base(Brightness b) {
    final esClaro = b == Brightness.light;

    final scheme = ColorScheme.fromSeed(
      seedColor: azulPetroleo,
      brightness: b,
      primary: esClaro ? azulPetroleo : azulPetroleoOscuro,
    );

    final radio = BorderRadius.circular(16);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor:
          esClaro ? fondo : const Color(0xFF1E1714),

      // COMMIT 2
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: azulPetroleo,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: azulPetroleo,
        ),
      ),

      // COMMIT 3
      cardTheme: CardThemeData(
        elevation: 0,
        color: esClaro ? Colors.white : const Color(0xFF2B201C),
        shape: RoundedRectangleBorder(
          borderRadius: radio,
          side: const BorderSide(
            color: Color(0xFFD6D6D6),
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
      ),

      // COMMIT 4
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:
            esClaro ? Colors.white : const Color(0xFF2B201C),

        border: OutlineInputBorder(
          borderRadius: radio,
          borderSide: const BorderSide(
            color: Color(0xFFD6D6D6),
            width: 1,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: radio,
          borderSide: const BorderSide(
            color: Color(0xFFD6D6D6),
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: radio,
          borderSide: const BorderSide(
            color: azulPetroleo,
            width: 2,
          ),
        ),
      ),

      // COMMIT 5
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: radio,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // COMMIT 5
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: radio,
          ),
        ),
      ),

      // COMMIT 5
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: azulPetroleo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: radio,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  static final light = _base(Brightness.light);
  static final dark = _base(Brightness.dark);
}

/// AppBar plana con línea inferior
class AppBarAzul extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarAzul({
    super.key,
    required this.titulo,
    this.actions,
  });

  final String titulo;
  final List<Widget>? actions;

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: const Color(0xFFD6D6D6),
        ),
      ),
    );
  }
}