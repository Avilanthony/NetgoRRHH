import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/editables.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/gestion_usuarios.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/notificacion_personal.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  final token;
  const Settings({@required this.token, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

late String _token;

class _SettingsState extends State<Settings> {
  
  late String usuario = '';
  String usuarioPrimerNombre = '';
  String usuarioSegundoNombre = '';
  String usuarioPrimerApellido = '';
  String usuarioSegundoApellido = '';
  String usuarioDepartamento = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
    _token = widget.token; 
    obtenerInformacionUsuario();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 192, 195, 255),
      constraints: const BoxConstraints.expand(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Ajustes".toUpperCase(),
                      style: GoogleFonts.croissantOne(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 30,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      itemSettings('Usuarios', CupertinoIcons.person_2_fill,
                          Colors.black, context),
                      itemSettings('Notificar', CupertinoIcons.bell,
                          Colors.black, context),
                      /* itemSettings('Editables', CupertinoIcons.building_2_fill,
                          Colors.black, context), */
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

itemSettings(
    String title, IconData iconData, Color background, BuildContext context) {
  return GestureDetector(
    onTap: () {
      switch (title) {
        case 'Usuarios':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GestionUsuariosPage()),
          );
          break;
        case 'Notificar':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonalNotificationScreen(token: _token)),
          );
          break;
        case 'Editables':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditsViewScreen()),
          );
          break;
        default:
          break;
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(5, 5),
            color: Color.fromARGB(128, 12, 62, 181),
            spreadRadius: 2,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.breeSerif(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    ),
  );
}
