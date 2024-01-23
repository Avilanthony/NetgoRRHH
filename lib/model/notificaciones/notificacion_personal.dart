// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:recursos_humanos_netgo/config.dart';

class PersonalNotificationScreen extends StatefulWidget {
  const PersonalNotificationScreen({super.key});

  @override
  _PersonalNotificationScreenState createState() => _PersonalNotificationScreenState();
}

class _PersonalNotificationScreenState extends State<PersonalNotificationScreen> {
  List<String> _departamentosUsuario = [];
  List<Map<String, dynamic>> _usuariosPorDepartamento = [];
  List<int> _idsDepartamentos = [];
  Map<String, int> _departamentosIdMap = {};
  bool showDepartmentDropdown = false;
  bool showPersonDropdown = false;

  String? _valorSelec;
  int? _idSelec;

  @override
  void initState() {
    super.initState();
    // Llamar a la función para obtener la lista de departamentos al inicio
    _getDepartamentos();
  }

  Future<void> _getDepartamentos() async {
    try {
      final response = await http.get(Uri.parse(llenar_select_deptos));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['status']) {
        final data = json.decode(response.body);
        final departamentos =
            List<String>.from(data['departamento'].map((dep) => dep['DEPARTAMENTO']));
        final idsDepartamento =
            List<int>.from(data['departamento'].map((dep) => dep['ID_DEPARTAMENTO']));

        setState(() {
          _departamentosUsuario = departamentos;
          _idsDepartamentos = idsDepartamento;
          _valorSelec = _departamentosUsuario.isNotEmpty ? _departamentosUsuario[0] : null;
          _idSelec = _idsDepartamentos.isNotEmpty ? _idsDepartamentos[0] : null;
        });

        for (final dep in data['departamento']) {
          _departamentosIdMap[dep['DEPARTAMENTO']] = dep['ID_DEPARTAMENTO'];
        }

        print("ChatGPT : $_departamentosIdMap");
        print("Los departamentos son: $_departamentosUsuario");
        print("Los IDs son: $_idsDepartamentos");
        print("Hola");
      } else {
        showToast(jsonResponse['msg']);
        print("Algo anda mal");
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al traer los departamentos.');
    }
  }

  Future<void> _getUsuariosPorDepartamento(String departamento) async {
    if (departamento == "TODOS") {
      try {
        /* final idDepartamento = _departamentosUsuario.indexOf(departamento) + 1; */

        final response = await http.get(Uri.parse(traer_todos_usuarios_deptos));
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        if (jsonResponse['status']) {
          final data = json.decode(response.body);
          /* final usuarios = List<String>.from(data['usuario'].map((dep) => dep['NOMBRE'] + ' ' + dep['APELLIDO'])); */
          final usuarios = List<Map<String, dynamic>>.from(data['todosUsuarios'].map((dep) => {
            'id': dep['ID'],
            'nombreCompleto': dep['NOMBRE'] + ' ' + dep['APELLIDO'],
            'departamentousuario': dep['NOMBRE_DEP'],
          }));
          /* final idsUsuarios = List<int>.from(data['usuario'].map((dep) => dep['ID'])); */
          setState(() {
            _usuariosPorDepartamento = usuarios;
            /* _idsUsuariosPorDepartamento = idsUsuarios; */
          });
          /* print("El id debe ser este: $idDepartamento"); */
          print('Detalles de los usuarios: $data');
          /* print("Usuarios del departamento $departamento: $usuarios "); *//* con ID: $idsUsuarios */
          print("Usuarios del departamento $departamento: $usuarios");
          print(usuarios);

          // Puedes continuar con la lógica para mostrar los usuarios en tu aplicación.

        } else {
          showToast(jsonResponse['msg']);
          print("Algo anda mal al obtener usuarios");
        }
      } catch (error) {
        print(error);
        showToast('Hubo un problema al obtener los usuarios.');
      } 

    } else {
      try {
        /* final idDepartamento = _departamentosUsuario.indexOf(departamento) + 1; */
        final idDepartamento = _departamentosIdMap[departamento];
        final response = await http.get(Uri.parse('$traer_usuario_cada_depto/$idDepartamento'));
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        if (jsonResponse['status']) {
          final data = json.decode(response.body);
          /* final usuarios = List<String>.from(data['usuario'].map((dep) => dep['NOMBRE'] + ' ' + dep['APELLIDO'])); */
          final usuarios = List<Map<String, dynamic>>.from(data['usuario'].map((dep) => {
            'id': dep['ID'],
            'nombreCompleto': dep['NOMBRE'] + ' ' + dep['APELLIDO'],
            'departamentousuario': dep['NOMBRE_DEP'],
          }));
          /* final idsUsuarios = List<int>.from(data['usuario'].map((dep) => dep['ID'])); */
          setState(() {
            _usuariosPorDepartamento = usuarios;
            /* _idsUsuariosPorDepartamento = idsUsuarios; */
          });
          print("El id debe ser este: $idDepartamento");
          /* print("El id ChatGPT debe ser este: $pruebi"); */
          print('Detalles de los usuarios: $data');
          /* print("Usuarios del departamento $departamento: $usuarios "); *//* con ID: $idsUsuarios */
          print("Usuarios del departamento $departamento: $usuarios");
          print(usuarios);

          // Puedes continuar con la lógica para mostrar los usuarios en tu aplicación.

        } else {
          showToast(jsonResponse['msg']);
          print("Algo anda mal al obtener usuarios");
        }
      }catch (error) {
        print(error);
        showToast('Hubo un problema al obtener los usuarios.');
      } 
    }  
  }

  void updateUsuariosList() {
    setState(() {
      // Llamada a _getUsuariosPorDepartamento() u otras acciones de actualización
      _getUsuariosPorDepartamento(_valorSelec!);
    });
  }

  _GestionUsuariosPageState() {
    // Asegúrate de que _departamentosUsuario no esté vacío antes de asignar el valor
    _valorSelec =
        _departamentosUsuario.isNotEmpty ? _departamentosUsuario[0] : null;
    _idSelec = _idsDepartamentos.isNotEmpty ? _idsDepartamentos[0] : null;
  }

  // Función para mostrar toasts con FlutterToast
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'Enviar notificación',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                "Notificar".toUpperCase(),
                style: GoogleFonts.croissantOne(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 81, 124, 193),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: showDepartmentDropdown,
                    onChanged: (value) {
                      setState(() {
                        showDepartmentDropdown = value!;
                        showPersonDropdown = false;
                      });
                    },
                  ),
                  const Text('Por Departamento'),
                ],
              ),
              if (showDepartmentDropdown)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Selecciona el departamento al que quieres notificar",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField(
                        value: _valorSelec,
                        items: _departamentosUsuario
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _valorSelec = val as String;
                          });

                          print("Seleccionaste el Dep: $_valorSelec");

                          _getUsuariosPorDepartamento(_valorSelec!);

                          print(
                              "Seleccionaste el ID: ${_departamentosIdMap[_valorSelec]}");
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Color.fromARGB(255, 81, 124, 193),
                        ),
                        dropdownColor: const Color.fromARGB(255, 231, 241, 246),
                        decoration: const InputDecoration(
                          labelText: "Elige un Departamento",
                          prefixIcon: Icon(
                            CupertinoIcons.briefcase_fill,
                            color: Color.fromARGB(255, 81, 124, 193),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  Checkbox(
                    value: showPersonDropdown,
                    onChanged: (value) {
                      setState(() {
                        showPersonDropdown = value!;
                        showDepartmentDropdown = false;
                      });
                    },
                  ),
                  const Text('Por Usuario'),
                ],
              ),
              if (showPersonDropdown)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Selecciona el departamento del usuario a notificar",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField(
                        value: _valorSelec,
                        items: _departamentosUsuario
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _valorSelec = val as String;
                          });

                          print("Seleccionaste el Dep: $_valorSelec");

                          _getUsuariosPorDepartamento(_valorSelec!);

                          print(
                              "Seleccionaste el ID: ${_departamentosIdMap[_valorSelec]}");
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Color.fromARGB(255, 81, 124, 193),
                        ),
                        dropdownColor: const Color.fromARGB(255, 231, 241, 246),
                        decoration: const InputDecoration(
                          labelText: "Elige un Departamento",
                          prefixIcon: Icon(
                            CupertinoIcons.briefcase_fill,
                            color: Color.fromARGB(255, 81, 124, 193),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Selecciona el USUARIO al que quieres notificar",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField(
                        value: _valorSelec,
                        items: _departamentosUsuario
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _valorSelec = val as String;
                          });

                          print("Seleccionaste el Dep: $_valorSelec");

                          _getUsuariosPorDepartamento(_valorSelec!);

                          print(
                              "Seleccionaste el ID: ${_departamentosIdMap[_valorSelec]}");
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: Color.fromARGB(255, 81, 124, 193),
                        ),
                        dropdownColor: const Color.fromARGB(255, 231, 241, 246),
                        decoration: const InputDecoration(
                          labelText: "Elige un Usuario",
                          prefixIcon: Icon(
                            CupertinoIcons.briefcase_fill,
                            color: Color.fromARGB(255, 81, 124, 193),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              Text(
                "Asunto:",
                style: GoogleFonts.croissantOne(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 0),
              Container(
                padding: const EdgeInsets.all(15),
                child: const TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Asunto de la notificación...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Notificación:",
                style: GoogleFonts.croissantOne(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 0),
              Container(
                padding: const EdgeInsets.all(15),
                child: const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Descripción de la notificación...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 0),
              SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 81, 124, 193),
                  ),
                  child: const Text('Enviar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
