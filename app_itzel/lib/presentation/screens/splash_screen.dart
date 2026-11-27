import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../services/bienvenida_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  String mensaje = 'Conectando con la API...';

  @override
  void initState() {
    super.initState();
    _probarConexion();
  }

  Future<void> _probarConexion() async {
    try {
      // Prueba del puente: GET / debe responder "Bienvenido a la API".
      final res = await context.read<BienvenidaService>().bienvenida();
      debugPrint(res);
      if (mounted) setState(() => mensaje = res);
    } catch (e) {
      if (mounted) setState(() => mensaje = 'Sin conexión con la API');
    }
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          width: double.infinity,
          color: AppTheme.azulPetroleo,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.school_rounded,
                    size: 64, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text(
                'App Itzel',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              const SizedBox(height: 8),
              Text(mensaje,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 32),
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                    strokeWidth: 3, color: Colors.white),
              ),
            ],
          ),
        ),
      );
}
