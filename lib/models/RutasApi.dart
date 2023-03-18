class RutasApi {
  static const String baseUrl = "https://rojasmendez.atlitec.com.mx/api/";

  static const String login = "login";

  // Rutas para alumnos
  static const String listaAlumnos = "alumno/";
  static const String mostrarAlumno = "alumno/mostrar/";
  static const String guardarAlumno = "alumno/guardar";
  static const String eliminarAlumno = "alumno/eliminar/";

  // Rutas para materias
  static const String listaMaterias = "materia/";
  static const String mostrarMateria = "materia/mostrar/";
  static const String guardarMateria = "materia/guardar";
  static const String eliminarMateria = "materia/eliminar/";

  // Rutas para pases de lista
  static const String listaPases = "pase/";
  static const String mostrarPase = "pase/mostrar/";
  static const String guardarPase = "pase/guardar";
  static const String eliminarPase = "pase/eliminar/";

  // Rutas para profesores
  static const String listaProfesores = "profesor/";
  static const String mostrarProfesor = "profesor/mostrar/";
  static const String guardarProfesor = "profesor/guardar";
  static const String eliminarProfesor = "profesor/eliminar/";
}
