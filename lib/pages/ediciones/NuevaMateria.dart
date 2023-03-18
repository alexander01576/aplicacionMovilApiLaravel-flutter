import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/models/Materia.dart';
import 'package:http/http.dart' as http;

import '../../models/RutasApi.dart';
import '../PageMaterias.dart';

class NuevaMateria extends StatefulWidget {
  const NuevaMateria({Key? key, required this.idMateria}) : super(key: key);

  final int idMateria;
  @override
  State<NuevaMateria> createState() => _NuevaMateriaState(idMateria);
}

class _NuevaMateriaState extends State<NuevaMateria> {
  final _form = GlobalKey<FormState>();
  TextEditingController txtNombreController = TextEditingController();
  TextEditingController txtHorasXSemana = TextEditingController();
  final int idMateria;
  _NuevaMateriaState(this.idMateria);

  void guardarMateria() async {

    var rutaMatGuar = RutasApi.baseUrl + RutasApi.guardarMateria;
    print(rutaMatGuar);

    var response = await http.post(
        Uri.parse(rutaMatGuar),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': idMateria,
          'nombre': txtNombreController.text,
          'horasxsemana': txtHorasXSemana.text,
        }));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PageMaterias()));
    }
  }

  void obtenerMateria() async {

    var rutaMatMostrar = "${RutasApi.baseUrl}${RutasApi.mostrarMateria}$idMateria";
    print(rutaMatMostrar);

    var response = await http.get(
      Uri.parse(rutaMatMostrar),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> respMateria = jsonDecode(response.body);
      var objRes = Materia.fromJson(respMateria);

      txtNombreController.text = objRes.nombre;
      txtHorasXSemana.text = objRes.horas_x_semana.toString();
    }
  }

  void eliminarMateria() async {
    var rutaMatEliminar = "${RutasApi.baseUrl}${RutasApi.eliminarMateria}$idMateria";
    print(rutaMatEliminar);

    var response = await http.post(
      Uri.parse(rutaMatEliminar),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PageMaterias()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (idMateria != 0) {
      obtenerMateria();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edicion de Materias"),
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
                decoration: const InputDecoration(labelText: "Nombre"),
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
                controller: txtHorasXSemana,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Horas x Semana"),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                guardarMateria();
              },
              child: Text('Guardar'),
            ),
            Visibility(
              visible: idMateria != 0, // Si idMateria es distinto de cero, el botón es visible
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                ),
                onPressed: () {
                  eliminarMateria();
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
