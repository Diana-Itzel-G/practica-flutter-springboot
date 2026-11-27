/// Espejo de CarreraDTO en Spring Boot:
/// record CarreraDTO(Integer id, String nombre, Integer duracionSemestres, String modalidad)
class Carrera {
  final int? id;
  final String nombre;
  final int duracionSemestres;
  final String modalidad;

  Carrera({
    this.id,
    required this.nombre,
    required this.duracionSemestres,
    required this.modalidad,
  });

  factory Carrera.fromJson(Map j) => Carrera(
        id: j['id'],
        nombre: j['nombre'] ?? '',
        duracionSemestres: (j['duracionSemestres'] as num?)?.toInt() ?? 0,
        modalidad: j['modalidad'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'duracionSemestres': duracionSemestres,
        'modalidad': modalidad,
      };
}
