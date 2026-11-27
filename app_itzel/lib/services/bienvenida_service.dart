import 'package:dio/dio.dart';

class BienvenidaService {
  BienvenidaService(this.dio);
  final Dio dio;

  /// GET / : prueba de conexión con Spring Boot.
  Future<String> bienvenida() async {
    final res = await dio.get('/');
    return res.data.toString();
  }
}
