import '../../services/carrera_service.dart';
import '../models/carrera.dart';

/// Convierte el JSON del service en modelos Carrera.
class CarreraRepository {
  CarreraRepository(this.service);
  final CarreraService service;

  Future<List<Carrera>> getCarreras() async {
    final data = await service.getCarreras();
    return data.map((e) => Carrera.fromJson(e)).toList();
  }

  Future<Carrera> getCarrera(int id) async {
    final data = await service.getCarrera(id);
    return Carrera.fromJson(data);
  }

  Future<Carrera> crear(Carrera c) async {
    final data = await service.crear(c.toJson());
    return Carrera.fromJson(data);
  }

  Future<Carrera> actualizar(Carrera c) async {
    final data = await service.actualizar(c.id!, c.toJson());
    return Carrera.fromJson(data);
  }

  Future<void> eliminar(int id) => service.eliminar(id);
}
