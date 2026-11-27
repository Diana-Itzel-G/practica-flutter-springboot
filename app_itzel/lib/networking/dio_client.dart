import 'package:dio/dio.dart';

import '../core/constants/api_config.dart';

class DioClient {
  DioClient({String? token}) : _token = token; // ignore: prefer_initializing_formals

  /// Solo se usa si la API pide JWT. Esta API no lo pide.
  final String? _token;

  late final Dio dio = _crear();

  Dio _crear() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        handler.next(options);
      },
    ));

    // Muestra cada petición y respuesta en la consola.
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}
