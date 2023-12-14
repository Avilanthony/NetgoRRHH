import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:recursos_humanos_netgo/config.dart';

class RolesViewScreen extends StatefulWidget {
  const RolesViewScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RolesViewScreenState createState() => _RolesViewScreenState();
}

class _RolesViewScreenState extends State<RolesViewScreen> {
  List<Map<String, dynamic>> roles = [];

  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener los departamentos al iniciar la pantalla
    _fetchDepartments();
  }

  _fetchDepartments() async {
    try {
      final response = await http.get(Uri.parse('$selec_roles/roles'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['roles'] != null) {
          final List<dynamic> rolData = data['roles'];

          setState(() {
            roles = rolData.cast<Map<String, dynamic>>();
          });
        } else {
          print(
              'Error: El campo "rol" es nulo o no existe en la respuesta del servidor');
        }
      } else {
        print(
            'Error al obtener la lista de roles. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: const Color.fromARGB(255, 236, 237, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text(
                    "Roles",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "En este apartado puede agregar o eliminar el rol que quiera.",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        for (var rols in roles)
                          itemUsuarios(rols, context),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _displayDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 81, 124, 193),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Agregar Nuevo",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _removeRol(int rolId) async {
    try {
      final response =
          await http.delete(Uri.parse('$editables/delete_rol/$rolId'));

      if (response.statusCode == 200) {
        setState(() {
          roles
              .removeWhere((ro) => ro['ID_ROL'] == rolId);
        });
        print('Rol eliminado con éxito');
      } else {
        print(
            'Error al eliminar el rol. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }

  _createRol(String newrol) async {
    try {
      final response = await http.post(
        Uri.parse('$editables/create_rol/'),
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'rol': newrol.trim()}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          roles.add(responseData);
        });
        print('Rol creado con éxito');
      } else {
        print(
            'Error al crear el rol. Código de estado: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }


  itemUsuarios(Map<String, dynamic> rol, context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: const Color.fromARGB(179, 10, 47, 196).withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              ListTile(
                title: Text(rol['ROL'] as String),
                textColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              Positioned(
                top: 10,
                bottom: 10,
                right: 10,
                child: SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      _removeRol(rol['ID_ROL'] as int);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 211, 48, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Eliminar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  _displayDialog(BuildContext context) async {
    String newRol = '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Nuevo Rol'),
          content: TextField(
            onChanged: (value) {
              newRol = value.toUpperCase();
              print('Valor de newRol en onChanged: $newRol');
            },
            decoration:
                const InputDecoration(hintText: 'Nombre del Rol'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
                child: const Text('Agregar'),
                onPressed: () async {
                  print(
                      'Valor de newRol antes de _createRol: $newRol');
                  if (newRol.isNotEmpty) {
                    await _createRol(newRol);
                    Navigator.of(context).pop();
                    _fetchDepartments();
                  }
                }),
          ],
        );
      },
    );
  }
}
