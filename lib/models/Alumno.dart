class Alumno {
  final int id;
  final String nombre;
  final String matricula;
  final int edad;
  final int idMateria;

  Alumno(this.id, this.nombre, this.matricula, this.edad, this.idMateria);

  Alumno.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        matricula = json['matricula'],
        edad = json['edad'],
        idMateria = json['id_materia'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'matricula': matricula,
    'edad': edad,
    'id_materia': idMateria
  };
}
