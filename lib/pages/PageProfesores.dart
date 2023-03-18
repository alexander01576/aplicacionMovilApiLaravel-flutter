import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_laravel/models/Profesor.dart';
import 'package:flutter_laravel/pages/PageAlumnos.dart';
import 'package:flutter_laravel/pages/PageMaterias.dart';
import 'package:flutter_laravel/pages/ediciones/NuevoProfesor.dart';
import 'package:http/http.dart' as http;

import '../models/RutasApi.dart';

class PageProfesores extends StatefulWidget {
  const PageProfesores({Key? key}) : super(key: key);

  @override
  State<PageProfesores> createState() => _PageProfesoresState();
}

class _PageProfesoresState extends State<PageProfesores> {
  List<Profesor> profesores = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerProfesores();
  }

  void obtenerProfesores() async {
    var rutaProfesores = RutasApi.baseUrl + RutasApi.listaProfesores;
    print(rutaProfesores);

    var response = await http.get(
      Uri.parse(rutaProfesores),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);
      profesores =
          List<Profesor>.from(i.map((model) => Profesor.fromJson(model)));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Profesores"),
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.face),
              title: const Text('Alumnos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageAlumnos()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: profesores.length,
          itemBuilder: (context, index) {
            var profesor = profesores[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(profesor.nombre[0]),
              ),
              title: Text(profesor.nombre),
              subtitle: Text(profesor.gradoEstudios.toString()),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NuevoProfesor(idProfesor: profesor.id)));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NuevoProfesor(idProfesor: 0)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
