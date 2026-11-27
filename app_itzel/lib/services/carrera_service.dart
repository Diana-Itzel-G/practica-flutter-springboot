import 'package:dio/dio.dart';

/// Solo sabe las rutas: devuelve el JSON tal cual (List o Map).
class CarreraService {
  CarreraService(this.dio);
  final Dio dio;

  static const _ruta = '/api/carreras';

  Future<List> getCarreras() async {
    final res = await dio.get(_ruta);
    return res.data;
  }

  Future<Map> getCarrera(int id) async {
    final res = await dio.get('$_ruta/$id');
    return res.data;
  }

  Future<Map> crear(Map body) async {
    final res = await dio.post(_ruta, data: body);
    return res.data;
  }

  Future<Map> actualizar(int id, Map body) async {
    final res = await dio.put('$_ruta/$id', data: body);
    return res.data;
  }

  Future<void> eliminar(int id) async {
    await dio.delete('$_ruta/$id');
  }
}
