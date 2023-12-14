import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:recursos_humanos_netgo/config.dart';

class LocalViewScreen extends StatefulWidget {
  const LocalViewScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LocalViewScreen createState() => _LocalViewScreen();
}

class _LocalViewScreen extends State<LocalViewScreen> {
  List<Map<String, dynamic>> locales = [];

  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener los departamentos al iniciar la pantalla
    _fetchDepartments();
  }

  _fetchDepartments() async {
    try {
      final response = await http.get(Uri.parse('$selec_locales/locales'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['locales'] != null) {
          final List<dynamic> localData = data['locales'];

          setState(() {
            locales = localData.cast<Map<String, dynamic>>();
          });
        } else {
          print(
              'Error: El campo "local" es nulo o no existe en la respuesta del servidor');
        }
      } else {
        print(
            'Error al obtener la lista de locales. Código de estado: ${response.statusCode}');
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
                    "Locales",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "En este apartado puede agregar o eliminar los locales que quiera.",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        for (var locals in locales)
                          itemUsuarios(locals, context),
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

  _removeLocal(int localId) async {
    try {
      final response =
          await http.delete(Uri.parse('$editables/delete_local/$localId'));

      if (response.statusCode == 200) {
        setState(() {
          locales
              .removeWhere((loc) => loc['ID_LOCAL'] == localId);
        });
        print('Local eliminado con éxito');
      } else {
        print(
            'Error al eliminar el local. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }

  _createLocal(String newLocal) async {
    try {
      final response = await http.post(
        Uri.parse('$editables/create_local/'),
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'local': newLocal.trim()}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          locales.add(responseData);
        });
        print('Local creado con éxito');
      } else {
        print(
            'Error al crear el local. Código de estado: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }

  itemUsuarios(Map<String, dynamic> local, context) {
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
                title: Text(local['UBICACION'] as String),
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
                      _removeLocal(local['ID_LOCAL'] as int);
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
    String newLocal = '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Nuevo Local'),
          content: TextField(
            onChanged: (value) {
              newLocal = value.toUpperCase();
              print('Valor de newLocal en onChanged: $newLocal');
            },
            decoration:
                const InputDecoration(hintText: 'Nombre del Local'),
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
                      'Valor de newLocal antes de _createLocal: $newLocal');
                  if (newLocal.isNotEmpty) {
                    await _createLocal(newLocal);
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
