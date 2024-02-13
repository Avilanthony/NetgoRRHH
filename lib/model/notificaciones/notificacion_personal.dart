// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/config.dart';

class PersonalNotificationScreen extends StatefulWidget {
  final token;
  const PersonalNotificationScreen({required this.token, Key? key})
      : super(key: key);

  @override
  _PersonalNotificationScreenState createState() =>
      _PersonalNotificationScreenState();
}

class _PersonalNotificationScreenState
    extends State<PersonalNotificationScreen> {
  TextEditingController _asuntoController = TextEditingController();
  TextEditingController _detalleController = TextEditingController();

  List<String> _departamentosUsuario = [];
  List<int> _idsDepartamentos = [];
  Map<String, int> _departamentosIdMap = {};

  late String usuario = '';
  String usuarioPrimerNombre = '';
  String usuarioSegundoNombre = '';
  String usuarioPrimerApellido = '';
  String usuarioSegundoApellido = '';
  String usuarioDepartamento = '';

  String? _valorSelec;
  int? _idSelec;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
    obtenerInformacionUsuario();
    // Llamar a la función para obtener la lista de departamentos al inicio
    _getDepartamentos();
  }

  Future<void> obtenerInformacionUsuario() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$ticket/ticket_usuario/$usuario'), // Reemplaza con la URL correcta de tu backend
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        setState(() {
          // Actualiza el estado con la información del usuario
          usuarioPrimerNombre = myUsuario['PRIMER_NOMBRE'];
          usuarioSegundoNombre = myUsuario['SEGUNDO_NOMBRE'];
          usuarioPrimerApellido = myUsuario['APELLIDO_PATERNO'];
          usuarioSegundoApellido = myUsuario['APELLIDO_MATERNO'];
          usuarioDepartamento = myUsuario['DEPARTAMENTO'];
          //VER QUE TRAE LOS DATOS DESDE LA CONSOLA
          print(usuarioPrimerNombre);
          print(usuarioSegundoNombre);
          print(usuarioPrimerApellido);
          print(usuarioSegundoApellido);
          print(usuarioDepartamento);
          // Otros campos del usuario...
        });
      } else {
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja errores de red u otros errores aquí
      print('Error: $error');
    }
  }

  Future<void> _getDepartamentos() async {
    try {
      final response = await http.get(Uri.parse(llenar_select_deptos));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['status']) {
        final data = json.decode(response.body);
        final departamentos = List<String>.from(
            data['departamento'].map((dep) => dep['DEPARTAMENTO']));
        final idsDepartamento = List<int>.from(
            data['departamento'].map((dep) => dep['ID_DEPARTAMENTO']));

        setState(() {
          _departamentosUsuario = departamentos;
          _idsDepartamentos = idsDepartamento;
          _valorSelec = _departamentosUsuario.isNotEmpty
              ? _departamentosUsuario[0]
              : null;
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

  Future<void> _enviarNotificacion() async {
    try {
      final response = await http.post(
        Uri.parse('$ticket/enviar_noti_rrhh'),
        body: {
          'id_usuario_origen': usuario,
          'asunto': _asuntoController.text,
          'detalle': _detalleController.text,
          'id_Depto_Destino': _idSelec,
        },
      );
      print('-----------------------');
      print(usuario);
      print(_asuntoController.text);
      print(_detalleController.text);
      print(_idSelec);
      print('-----------------------');

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        showToast('Notificación enviada exitosamente');
      } else {
        showToast(jsonResponse['msg']);
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al enviar la notificación.');
    }
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
                    if (val != null) {
                      setState(() {
                        _valorSelec = val as String;
                        _idSelec = _departamentosIdMap[_valorSelec];
                      });
                    }
                    print("Seleccionaste el Dep: $_valorSelec");
                    print("Seleccionaste el ID: $_idSelec");
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
              const SizedBox(height: 20),
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
                child: TextField(
                  controller: _asuntoController,
                  maxLines: 1,
                  decoration: const InputDecoration(
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
                child: TextField(
                  controller: _detalleController,
                  maxLines: 4,
                  decoration: const InputDecoration(
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
                  onPressed: () {
                    _enviarNotificacion();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 81, 124, 193),
                  ),
                  child: const Text('Enviar',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
