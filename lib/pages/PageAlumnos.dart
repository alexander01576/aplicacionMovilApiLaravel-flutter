import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_laravel/models/RutasApi.dart';
import 'package:flutter_laravel/pages/PageMaterias.dart';
import 'package:flutter_laravel/pages/ediciones/NuevoAlumno.dart';
import 'package:http/http.dart' as http;

import '../models/Alumno.dart';
import 'PageProfesores.dart';

class PageAlumnos extends StatefulWidget {
  const PageAlumnos({Key? key}) : super(key: key);

  @override
  State<PageAlumnos> createState() => _PageAlumnosState();
}

class _PageAlumnosState extends State<PageAlumnos> {
  List<Alumno> alumnos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerAlumnos();
  }

  Future<void> obtenerAlumnos() async {
    var rutaAlmnos = RutasApi.baseUrl + RutasApi.listaAlumnos;
    print(rutaAlmnos);

    var response = await http.get(
      Uri.parse(rutaAlmnos),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);
      alumnos = List<Alumno>.from(i.map((model) => Alumno.fromJson(model)));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Alumnos"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.purpleAccent,
                ),
                child: Column(
                  children: [
                    // Expanded(
                    //     child: Image.network(
                    //         'https://cdn-icons-png.flaticon.com/512/1177/1177568.png')),
                    const SizedBox(height: 10),
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Materias'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageMaterias()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.portrait),
              title: const Text('Profesores'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageProfesores()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.face),
              title: const Text('Alumnos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: alumnos.length,
          itemBuilder: (context, index) {
            var alumno = alumnos[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(alumno.nombre[0]),
              ),
              title: Text(alumno.nombre),
              subtitle: Text(alumno.edad.toString()),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NuevoAlumno(idAlumno: alumno.id)));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NuevoAlumno(idAlumno: 0)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
