class Profesor {
  final int id;
  final String nombre;
  final String gradoEstudios;
  final int idMateria;

  Profesor(this.id, this.nombre, this.gradoEstudios, this.idMateria);

  Profesor.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        gradoEstudios = json['gradoEstudios'],
        idMateria = json['id_materia'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'gradoEstudios': gradoEstudios,
    'id_materia': idMateria
  };
}
