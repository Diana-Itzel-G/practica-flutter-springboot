import 'package:go_router/go_router.dart';

import '../presentation/screens/detalle_screen.dart';
import '../presentation/screens/form_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
    GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
    GoRoute(path: '/nuevo', builder: (_, _) => const FormScreen()),
    GoRoute(
      path: '/carrera/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return DetalleScreen(id: id);
      },
    ),
    GoRoute(
      path: '/editar/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return FormScreen(id: id);
      },
    ),
  ],
);
