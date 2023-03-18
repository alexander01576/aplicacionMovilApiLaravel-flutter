import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/models/Profesor.dart';
import 'package:flutter_laravel/models/RutasApi.dart';
import 'package:flutter_laravel/pages/PageProfesores.dart';
import 'package:http/http.dart' as http;
import '../../models/Materia.dart';

class NuevoProfesor extends StatefulWidget {
  const NuevoProfesor({Key? key, required this.idProfesor}) : super(key: key);
  final int idProfesor;
  @override
  State<NuevoProfesor> createState() => _NuevoProfesorState(idProfesor);
}

class _NuevoProfesorState extends State<NuevoProfesor> {
  final _form = GlobalKey<FormState>();
  List<Materia> materias = [];
  TextEditingController txtNombreController = TextEditingController();
  TextEditingController txtGradoEstudios = TextEditingController();
  TextEditingController txtIdMateria = TextEditingController();
  final int idProfesor;
  _NuevoProfesorState(this.idProfesor);

  void guardarProfesor () async {
    var rutaProfGuar = RutasApi.baseUrl + RutasApi.guardarProfesor;
    print(rutaProfGuar);
    var response = await http.post(
        Uri.parse(rutaProfGuar),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': idProfesor,
          'nombre': txtNombreController.text,
          'gradoEstudios': txtGradoEstudios.text,
          'id_materia': txtIdMateria.text,
        })
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PageProfesores()));
    }
  }

  void obtenerProfesor() async {
    var rutaProfMostrar = "${RutasApi.baseUrl}${RutasApi.mostrarProfesor}$idProfesor";
    print(rutaProfMostrar);
    var response = await http.get(
      Uri.parse(rutaProfMostrar),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> respMateria = jsonDecode(response.body);
      var objRes = Profesor.fromJson(respMateria);
      txtNombreController.text = objRes.nombre;
      txtGradoEstudios.text = objRes.gradoEstudios.toString();
      txtIdMateria.text = objRes.idMateria.toString();
    }
  }

  void eliminarProfesor() async {
    var rutaProfesorEliminar = "${RutasApi.baseUrl}${RutasApi.eliminarProfesor}$idProfesor";
    print(rutaProfesorEliminar);

    var response = await http.post(
      Uri.parse(rutaProfesorEliminar),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PageProfesores()));
    }
  }

  void obtenerMaterias() async {
    var rutaMaterias = RutasApi.baseUrl + RutasApi.listaMaterias;
    print(rutaMaterias);
    var response = await http.get(
      Uri.parse(rutaMaterias),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);
      materias = List<Materia>.from(i.map((model) => Materia.fromJson(model)));
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    obtenerMaterias();
    if (idProfesor != 0) {
      obtenerProfesor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edicion de Profesores"),
      ),

      body: Form(
        key: _form,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: TextFormField(
                validator: (text) {
                  if (text == "") {
                    return "Este campo es Obligatorio";
                  }

                  return null;
                },
                controller: txtNombreController,
                decoration: const InputDecoration(labelText: "Nombre profesor"),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: TextFormField(
                validator: (text) {
                  if (text == "") {
                    return "Este campo es Obligatorio";
                  }
                  return null;
                },
                controller: txtGradoEstudios,
                decoration: const InputDecoration(labelText: "Grado de estudios"),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: TextFormField(
                validator: (text) {
                  if (text == "") {
                    return "Este campo es Obligatorio";
                  }
                  return null;
                },
                controller: txtIdMateria,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Id Materia"),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                guardarProfesor();
              },
              child: Text('Guardar'),
            ),
            Visibility(
              visible: idProfesor != 0, // Si idMateria es distinto de cero, el botón es visible
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                ),
                onPressed: () {
                  eliminarProfesor();
                },
                child: Text('Eliminar'),
              ),
            )
          ],
        ),
      ),

    );
  }
}
