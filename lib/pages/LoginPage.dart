import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_laravel/models/RespLogin.dart';
import 'package:flutter_laravel/pages/PageMaterias.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import '../models/RutasApi.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final txtUserController = TextEditingController();
  final txtPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion escolar'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Image.network(
            //     'https://www.nicepng.com/png/full/126-1268312_apply-card-icon-college-student-student-icon.png',
            //     width: 200),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: TextField(
                controller: txtUserController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Usuario'),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: TextField(
                controller: txtPassController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Contraseña'),
              ),
            ),
            TextButton(
              child: Text("Accesar"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                fnLoginApp();
              },
            )
          ],
        ),
      ),
    );
  }

  void fnLoginApp() async {
    var rutaLogin = RutasApi.baseUrl + RutasApi.login;
    print(rutaLogin);
    var response = await http
        .post(Uri.parse(rutaLogin), headers: <String, String>{}, body: {
      "email": txtUserController.text,
      "password": txtPassController.text,
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> respLogin = jsonDecode(response.body);
      var objRes = RespLogin.fromJson(respLogin);
      if (!mounted) return;
      if (objRes.acceso == "Ok") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PageMaterias()));
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: objRes.error,
        );
      }
    }
  }
}
