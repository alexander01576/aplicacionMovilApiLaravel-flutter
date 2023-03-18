import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_laravel/models/Alumno.dart';
import 'package:flutter_laravel/pages/PageAlumnos.dart';

import 'package:http/http.dart' as http;


import '../../models/RutasApi.dart';

class NuevoAlumno extends StatefulWidget {
  const NuevoAlumno({Key? key, required this.idAlumno}) : super(key: key);

  final int idAlumno;

  @override
  State<NuevoAlumno> createState() => _NuevoAlumnoState(idAlumno);
}

class _NuevoAlumnoState extends State<NuevoAlumno> {

  final _form = GlobalKey<FormState>();
  TextEditingController txtNombreController = TextEditingController();
  TextEditingController txtMatriculaController = TextEditingController();
  TextEditingController txtEdadController = TextEditingController();
  TextEditingController txtIdMateriaController = TextEditingController();
  final int idAlumno;

  _NuevoAlumnoState(this.idAlumno);

  void guardarAlumno() async {

    var rutaalumnoGuar = RutasApi.baseUrl + RutasApi.guardarAlumno;
    print(rutaalumnoGuar);

    var response = await http.post(
        Uri.parse(rutaalumnoGuar),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': idAlumno,
          'nombre': txtNombreController.text,
          'matricula': txtMatriculaController.text,
          'edad': txtEdadController.text,
          'id_materia': txtIdMateriaController.text,
        }));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PageAlumnos()));
    }
  }

  void obtenerAlumno() async {

    var rutaAlumnoMostrar = "${RutasApi.baseUrl}${RutasApi.mostrarAlumno}$idAlumno";
    print(rutaAlumnoMostrar);

    var response = await http.get(
      Uri.parse(rutaAlumnoMostrar),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> respAlumno = jsonDecode(response.body);
      var objRes = Alumno.fromJson(respAlumno);

      txtNombreController.text = objRes.nombre;
      txtMatriculaController.text = objRes.matricula;
      txtEdadController.text = objRes.edad.toString();
      txtIdMateriaController.text = objRes.idMateria.toString();
    }
  }

  void eliminarAlumno() async {
    var rutaAlumnoEliminar = "${RutasApi.baseUrl}${RutasApi.eliminarAlumno}$idAlumno";
    print(rutaAlumnoEliminar);

    var response = await http.post(
      Uri.parse(rutaAlumnoEliminar),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PageAlumnos()
          )
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (idAlumno != 0) {
      obtenerAlumno();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edicion de Alumnos"),
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
                decoration: const InputDecoration(labelText: "Nombre Alumno"),
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
                controller: txtMatriculaController,
                decoration: const InputDecoration(labelText: "Matricula"),
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
                controller: txtEdadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Edad"),
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
                controller: txtIdMateriaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Id Materia"),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                guardarAlumno();
              },
              child: Text('Guardar'),
            ),
            Visibility(
              visible: idAlumno != 0, // Si idMateria es distinto de cero, el botón es visible
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                ),
                onPressed: () {
                  eliminarAlumno();
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
