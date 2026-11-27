import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/models/carrera.dart';
import '../../domain/repository/carrera_repository.dart';

class CarreraController extends ChangeNotifier {
  CarreraController(this.repo);
  final CarreraRepository repo;

  List<Carrera> items = [];
  bool loading = false;
  String? error;

  Carrera? detalle;
  bool loadingDetalle = false;
  String? errorDetalle;

  Future<void> cargar() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      items = await repo.getCarreras();
    } catch (e) {
      error = 'No se pudo conectar con la API';
    }
    loading = false;
    notifyListeners();
  }

  Future<void> cargarDetalle(int id) async {
    loadingDetalle = true;
    detalle = null;
    errorDetalle = null;
    notifyListeners();
    try {
      detalle = await repo.getCarrera(id);
    } catch (e) {
      errorDetalle = 'No se encontró la carrera $id';
    }
    loadingDetalle = false;
    notifyListeners();
  }

  /// Devuelve null si salió bien, o el mensaje de error.
  Future<String?> crear(String nombre, int semestres, String modalidad) async {
    try {
      await repo.crear(Carrera(
          nombre: nombre, duracionSemestres: semestres, modalidad: modalidad));
      await cargar();
      return null;
    } catch (e) {
      return 'No se pudo guardar';
    }
  }

  Future<String?> actualizar(
      int id, String nombre, int semestres, String modalidad) async {
    try {
      await repo.actualizar(Carrera(
          id: id,
          nombre: nombre,
          duracionSemestres: semestres,
          modalidad: modalidad));
      await cargar();
      return null;
    } catch (e) {
      return 'No se pudo actualizar';
    }
  }

  Future<String?> eliminar(int id) async {
    try {
      await repo.eliminar(id);
      await cargar();
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        await cargar();
        return 'La carrera ya no existe';
      }
      return 'No se pudo eliminar la carrera';
    } catch (e) {
      return 'No se pudo eliminar la carrera';
    }
  }
}
