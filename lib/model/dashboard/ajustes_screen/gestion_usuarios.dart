import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/configurar_usuario.dart';

import 'package:http/http.dart' as http;


class GestionUsuariosPage extends StatefulWidget {
  const GestionUsuariosPage({super.key});
  @override
  _GestionUsuariosPageState createState() => _GestionUsuariosPageState();
}

class _GestionUsuariosPageState extends State<GestionUsuariosPage> {

  List<String> _departamentosUsuario = [];
  List<Map<String, dynamic>> _usuariosPorDepartamento = [];
  /* var idDepto; */

  @override
  void initState() {
    super.initState();
    // Llamar a la función para obtener la lista de departamentos al inicio
    _getDepartamentos();
  }

  Future<void> _getDepartamentos() async { //LAMAR LA SOLICITUD DEL BACKEND
    try {
      final response = await http.get(Uri.parse(llenar_select_deptos));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['status']) {
        final data = json.decode(response.body);
        final departamentos = List<String>.from(data['departamento'].map((dep) => dep['DEPARTAMENTO']));
        /* final idDepartamento = data['departamento'].map((dep) => dep['ID_DEPARTAMENTO']); */ //LANZA VACÍO
        /* final idDepartamento = data['departamento'].first['ID_DEPARTAMENTO']; */  //FUNCIONA SÓLO RRHH Usar el primer ID
        /* final idDepartamento = data['departamento'].map((dep) => dep['DEPARTAMENTO'] == _valorSelec)['ID_DEPARTAMENTO']; */
        /* final idDepartamento = data['departamento'].firstWhere((dep) => dep['DEPARTAMENTO'] == _valorSelec)['ID_DEPARTAMENTO']; //NO FUNCIONA */
        /* final index = departamentos.indexOf(_valorSelec);
        final idDepartamento = data['departamento'][index]['ID_DEPARTAMENTO']; */
        setState(() {
          _departamentosUsuario = departamentos;
          /* idDepto = idDepartamento; */
          /* idDepto = data['departamento'].firstWhere((dep) => dep['DEPARTAMENTO'] == _valorSelec)['ID_DEPARTAMENTO']; */
          // Puedes agregar más lógica aquí según tus necesidades
        });
        
        
        print("Hola");
      } else {
        
        // Manejar errores aquí
        showToast(jsonResponse['msg']);
          print("Algo anda mal");
      }
    } catch (error) {
      // Manejar errores de red o cualquier otra excepción
      print(error);
      showToast('Hubo un problema al traer los departamentos.');
    }
  }

  Future<void> _getUsuariosPorDepartamento(String departamento) async {
    try {
      final idDepartamento = _departamentosUsuario.indexOf(departamento) + 1;

      final response = await http.get(Uri.parse('$traer_usuario_cada_depto/$idDepartamento'));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['status']) {
        final data = json.decode(response.body);
        /* final usuarios = List<String>.from(data['usuario'].map((dep) => dep['NOMBRE'] + ' ' + dep['APELLIDO'])); */
        final usuarios = List<Map<String, dynamic>>.from(data['usuario'].map((dep) => {
          'id': dep['ID'],
          'nombreCompleto': dep['NOMBRE'] + ' ' + dep['APELLIDO'],
        }));
        /* final idsUsuarios = List<int>.from(data['usuario'].map((dep) => dep['ID'])); */
        setState(() {
          _usuariosPorDepartamento = usuarios;
          /* _idsUsuariosPorDepartamento = idsUsuarios; */
        });
        print("El id debe ser este: $idDepartamento");
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
  }

  _GestionUsuariosPageState() {
    // Asegúrate de que _departamentosUsuario no esté vacío antes de asignar el valor
    _valorSelec = _departamentosUsuario.isNotEmpty ? _departamentosUsuario[0] : null;
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

  String? _valorSelec = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 255),
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        backgroundColor: const Color.fromARGB(255, 247, 247, 255),
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
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Text(
                            "Seleccionar Usuarios",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Selecciona el departamento al que quieres gestionar",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
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

                                print("Seleccionaste: $_valorSelec");
                                _getUsuariosPorDepartamento(_valorSelec!);
                                
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Color.fromARGB(255, 81, 124, 193),
                              ),
                              dropdownColor:
                                  const Color.fromARGB(255, 231, 241, 246),
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
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Selecciona el usuario al que quieras gestionar",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                              textAlign: TextAlign.center,
                            ),
                            
                          ),
                          const SizedBox(height: 15),

                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(

                              children: <Widget>[

                                /* itemUsuarios('Anthony Avila', 'Contabilidad', context),
                                itemUsuarios('Adoniss Ponce', 'Contabilidad', context),
                                itemUsuarios('Henry Cabrera', 'Contabilidad', context), */
                                for (var usuario in _usuariosPorDepartamento)
                                itemUsuarios(usuario, _valorSelec, context),

                              ]

                            )),

                          const Padding(
                            padding:  EdgeInsets.all(20),
                            child: Column(

                              //itemUsuarios('Anthony Avila', 'Contabilidad',),

                            )
                          ),
                          
                        ],
                      )
                    ]
                  )
                )
              )
            )

    );
  }
 
}

itemUsuarios(Map<String, dynamic> usuario, String? depart, context) {

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  } 

  String capitalizeFullName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    List<String> capitalizedParts = nameParts.map((part) => capitalize(part)).toList();
    return capitalizedParts.join(' ');
  }

  String capitalizedNombre = capitalizeFullName(usuario['nombreCompleto']);
  // Convierte la primera letra de nombreComp a mayúscula
  /* String formattedNombreComp = nombreComp.isNotEmpty
      ? nombreComp[0].toUpperCase() + nombreComp.substring(1)
      : nombreComp; */


  /* String capitalizedDepart = depart != null ? capitalize(depart) : ''; */

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
              subtitle: Text(depart!,
              style: TextStyle(
                fontSize: 15, color: Colors.grey[700])),
              title: Text(capitalizedNombre),
              
              
              textColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            Positioned(
              top: 10,
              bottom: 10,
              right: 10,
              child: Container(
                width: 130,
                child: ElevatedButton(
                          //minWidth: double.infinity,
                          //height: 0,
                          onPressed: () {
                             Navigator.push(
                              context, MaterialPageRoute(builder: (context) => ConfiguracionUsuariosPage(usuarioId: usuario['id'])));
                              
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 81, 124, 193), // Cambia el color del botón a rojo
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25), // Bordes redondeados
                            ),
                          ),
                          //: Color.fromARGB(255, 81, 124, 193),
                          //elevation: 0,
                          child: const Text(
                            "Gestionar",
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

