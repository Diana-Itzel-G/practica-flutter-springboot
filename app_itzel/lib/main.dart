import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'domain/repository/carrera_repository.dart';
import 'networking/dio_client.dart';
import 'presentation/controllers/carrera_controller.dart';
import 'routes/app_router.dart';
import 'services/bienvenida_service.dart';
import 'services/carrera_service.dart';

void main() {
  final dio = DioClient().dio;

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => BienvenidaService(dio)),
        ChangeNotifierProvider(
          create: (_) =>
              CarreraController(CarreraRepository(CarreraService(dio)))
                ..cargar(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Itzel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
