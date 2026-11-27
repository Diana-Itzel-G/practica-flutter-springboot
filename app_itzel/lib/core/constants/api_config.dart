import 'package:flutter/foundation.dart';

class ApiConfig {
  // Emulador Android: 10.0.2.2 es el alias del localhost de la PC.
  // iOS, web o escritorio: localhost.
  // Celular físico: usar la IP de la PC (ipconfig), ej. 'http://192.168.x.x:8080'.
  // Puerto opcional: flutter run --dart-define=API_PORT=8081
  static const _port = String.fromEnvironment('API_PORT', defaultValue: '8080');

  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:$_port';
    }
    return 'http://localhost:$_port';
  }
}
