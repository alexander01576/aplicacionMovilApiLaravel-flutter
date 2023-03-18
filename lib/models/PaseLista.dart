class PaseLista {
  final int id;
  final String fecha;
  final int idAlumno;
  final int idMateria;
  final bool asistencia;

  PaseLista(
      this.id, this.fecha, this.idAlumno, this.idMateria, this.asistencia);

  PaseLista.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fecha = json['fecha'],
        idAlumno = json['id_alumno'],
        idMateria = json['id_materia'],
        asistencia = json['asistencia'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'fecha': fecha,
    'id_alumno': idAlumno,
    'id_materia': idMateria,
    'asistencia': asistencia
  };
}
