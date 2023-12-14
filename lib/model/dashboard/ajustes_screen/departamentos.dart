import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:recursos_humanos_netgo/config.dart';

class DepartamentViewScreen extends StatefulWidget {
  const DepartamentViewScreen({Key? key}) : super(key: key);

  @override
  _DepartamentViewScreen createState() => _DepartamentViewScreen();
}

class _DepartamentViewScreen extends State<DepartamentViewScreen> {
  List<Map<String, dynamic>> departments = [];

  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener los departamentos al iniciar la pantalla
    _fetchDepartments();
  }

  _fetchDepartments() async {
    try {
      final response = await http.get(Uri.parse('$selec_deptos/departamentos'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['departamento'] != null) {
          final List<dynamic> departamentosData = data['departamento'];

          setState(() {
            departments = departamentosData.cast<Map<String, dynamic>>();
          });
        } else {
          print(
              'Error: El campo "departamento" es nulo o no existe en la respuesta del servidor');
        }
      } else {
        print(
            'Error al obtener la lista de departamentos. Código de estado: ${response.statusCode}');
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
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text(
                    "Departamentos",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "En este apartado puede agregar o eliminar el departamento que quiera.",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        for (var department in departments)
                          itemUsuarios(department, context),
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

  _removeDepartment(int departmentId) async {
    try {
      final response =
          await http.delete(Uri.parse('$editables/delete_dep/$departmentId'));

      if (response.statusCode == 200) {
        setState(() {
          departments
              .removeWhere((dep) => dep['ID_DEPARTAMENTO'] == departmentId);
        });
        print('Departamento eliminado con éxito');
      } else {
        print(
            'Error al eliminar el departamento. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }

  _createDepartment(String newDepartment) async {
    try {
      final response = await http.post(
        Uri.parse('$editables/create_dep/'),
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'departamento': newDepartment.trim()}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          departments.add(responseData);
        });
        print('Departamento creado con éxito');
      } else {
        print(
            'Error al crear el departamento. Código de estado: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }

  itemUsuarios(Map<String, dynamic> department, context) {
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
                title: Text(department['DEPARTAMENTO'] as String),
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
                      _removeDepartment(department['ID_DEPARTAMENTO'] as int);
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
    String newDepartment = '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Nuevo Departamento'),
          content: TextField(
            onChanged: (value) {
              newDepartment = value.toUpperCase();
              print('Valor de newDepartment en onChanged: $newDepartment');
            },
            decoration:
                const InputDecoration(hintText: 'Nombre del Departamento'),
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
                      'Valor de newDepartment antes de _createDepartment: $newDepartment');
                  if (newDepartment.isNotEmpty) {
                    await _createDepartment(newDepartment);
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
