import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TicketsPage extends StatefulWidget {
  dynamic token;
  TicketsPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPage();
}

class _TicketsPage extends State<TicketsPage> {
  TextEditingController controladorAsunto = TextEditingController();
  TextEditingController controladorDetalle = TextEditingController();

  late String usuario = '';
  String usuarioPrimerNombre = '';
  String usuarioPrimerApellido = '';
  String usuarioDepto = '';
  String? usuarioImagen = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
    obtenerInformacionUsuario();
  }

  Future<void> enviarTicket(String asunto, String detalle) async {
    try {
      final response = await http.post(
        Uri.parse('$ticket/enviar_ticket'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id_usuario_origen': usuario,
          'asunto': 'Ticket - $asunto',
          'detalle': detalle,
          'departamento_usuario': usuarioDepto,
        }),
      );

      if (response.statusCode == 200) {
        // Solicitud exitosa, puedes manejar la respuesta según sea necesario
        print('Notificación enviada exitosamente');

        // Limpiar los TextFields
        controladorAsunto.clear();
        controladorDetalle.clear();

        // Mostrar mensaje de éxito
        mostrarMensaje('Notificación enviada exitosamente');
      } else {
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja errores de red u otros errores aquí
      print('Error: $error');
    }
  }

  Future<void> obtenerInformacionUsuario() async {
    try {
      final response = await http.get(
        Uri.parse('$ticket/ticket_usuario/$usuario'),
      );

      print("Esta es la respuesta $response");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        setState(() {
          usuarioPrimerNombre = myUsuario['PRIMER_NOMBRE'];
          usuarioPrimerApellido = myUsuario['APELLIDO_PATERNO'];
          usuarioDepto = myUsuario['DEPARTAMENTO'];
          usuarioImagen = myUsuario['IMG'];
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("------------------------------");
    print(usuarioImagen);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                const SizedBox(height: 8),
                Text(
                  "Tickets".toUpperCase(),
                  style: GoogleFonts.croissantOne(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Text(
                  "\nCrear un ticket para el \n departamento de recursos humanos",
                  style: GoogleFonts.croissantOne(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TicketWidget(
                  width: 300,
                  height: 500,
                  isCornerRounded: true,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 60,
                                child: (usuarioImagen != null)
                                    ? CircleAvatar(
                                        radius: 55,
                                        backgroundImage:
                                            NetworkImage(usuarioImagen!),
                                      )
                                    : const CircleAvatar(
                                        radius: 55,
                                        backgroundImage: AssetImage(
                                          'assets/images/user.png',
                                        ),
                                      ),
                              ),
                              Text(
                                "$usuarioPrimerNombre $usuarioPrimerApellido",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.archive,
                                    color: Colors.blueGrey,
                                    size: 18,
                                  ),
                                  Text(
                                    "Dep. $usuarioDepto",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueGrey,
                                    ),
                                  )
                                ],
                              ),
                              TextField(
                                key: Key('campoAsunto'),
                                controller: controladorAsunto,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Asunto',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                maxLines: 8,
                                controller: controladorDetalle,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Ingrese una descripción...',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () {
                      String asunto = controladorAsunto.text;
                      String detalle = controladorDetalle.text;
                      enviarTicket(asunto, detalle);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 139, 194, 68),
                    ),
                    child: const Text('Enviar',
                    style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
