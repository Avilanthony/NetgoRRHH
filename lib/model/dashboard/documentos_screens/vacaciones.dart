import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:recursos_humanos_netgo/config.dart';
// ignore: depend_on_referenced_packages
//import 'package:intl/intl.dart';

class VacationRequestScreen extends StatefulWidget {
  final token;
  const VacationRequestScreen({required this.token, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VacationRequestScreenState createState() => _VacationRequestScreenState();
}

class _VacationRequestScreenState extends State<VacationRequestScreen> {
  late String usuario = '';
  String usuarioPrimerNombre = '';
  String usuarioPrimerApellido = '';
  String usuarioVacaciones = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
    obtenerInformacionUsuario();
  }

  Future<void> obtenerInformacionUsuario() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$perfilUsuario/vacaciones/$usuario'), // Reemplaza con la URL correcta de tu backend
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        setState(() {
          // Actualiza el estado con la información del usuario
          usuarioPrimerNombre = myUsuario['PRIMER_NOMBRE'];
          usuarioPrimerApellido = myUsuario['APELLIDO_PATERNO'];
          usuarioVacaciones = myUsuario['VACACIONES'].toString();
          //VER QUE TRAE LOS DATOS DESDE LA CONSOLA
          print(usuarioPrimerNombre);
          print(usuarioPrimerApellido);
          print(usuarioVacaciones);
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 81, 124, 193),
          title: Text.rich(
            TextSpan(
                text: 'VACACIONES',
                style: GoogleFonts.josefinSans(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            /* padding: const EdgeInsets.only(left: 20, right: 20, top: 40), */
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Hola, $usuarioPrimerNombre $usuarioPrimerApellido",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Tus vacaciones disponibles son:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[780],
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          height: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: 
                        Text(
                          usuarioVacaciones,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 81, 124, 193),
                            fontSize: 90,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          height: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Si tienes alguna consulta, puedes abocarte con nosotros por medio de mensaje privado.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[780],
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Personaje4.png"),
                          fit: BoxFit.cover)),
                )
              ],
            )));
  }
}
