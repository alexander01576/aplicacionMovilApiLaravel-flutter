import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_laravel/models/Materia.dart';
import 'package:flutter_laravel/pages/PageAlumnos.dart';
import 'package:flutter_laravel/pages/ediciones/NuevaMateria.dart';
import 'package:flutter_laravel/pages/PageProfesores.dart';
import 'package:http/http.dart' as http;

import '../models/RutasApi.dart';

class PageMaterias extends StatefulWidget {
  const PageMaterias({Key? key}) : super(key: key);

  @override
  State<PageMaterias> createState() => _PageMateriasState();
}

class _PageMateriasState extends State<PageMaterias> {
  List<Materia> materias = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerMaterias();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de materias"),
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
                Navigator.pop(context);
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
          itemCount: materias.length,
          itemBuilder: (context, index) {
            var materia = materias[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(materia.id.toString()),
              ),
              title: Text(materia.nombre),
              subtitle: Text(materia.horas_x_semana.toString()),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NuevaMateria(idMateria: materia.id)));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NuevaMateria(idMateria: 0)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
