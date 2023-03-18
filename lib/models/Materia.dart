class Materia{
  final int id;
  final String nombre;
  final int horas_x_semana;

  Materia(this.id, this.nombre, this.horas_x_semana);

  Materia.fromJson(Map<String, dynamic>json)
      :
        id = json['id'],
        nombre = json ['nombre'],
        horas_x_semana = json ['horasxsemana'];

  Map<String, dynamic> ToJson() =>{
    'id': id,
    'nombre': nombre,
    'horasxsemana': horas_x_semana
  };
}