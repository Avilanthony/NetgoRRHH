import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TicketsPage extends StatefulWidget {
  final token;
  const TicketsPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<TicketsPage> createState() => _TicketsPage();
}

class _TicketsPage extends State<TicketsPage> {

  late String usuario = '';
  String usuarioPrimerNombre = '';
  String usuarioPrimerApellido = '';
  String usuarioDepto = '';
  String usuarioImagen = '';

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
            '$ticket/ticket_usuario/$usuario'), // Reemplaza con la URL correcta de tu backend
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        setState(() {
          // Actualiza el estado con la información del usuario
          usuarioPrimerNombre = myUsuario['PRIMER_NOMBRE'];
          usuarioPrimerApellido = myUsuario['APELLIDO_PATERNO'];
          usuarioDepto = myUsuario['DEPARTAMENTO'];
          usuarioImagen = myUsuario['IMG'];
          //VER QUE TRAE LOS DATOS DESDE LA CONSOLA
          print(usuarioPrimerNombre);
          print(usuarioPrimerApellido);
          print(usuarioDepto);
          print(usuarioImagen);
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

triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10, 
        channelKey: 'basic_channel',
        title: 'Asunto',
        body: 'Descripcion del asunto',
        payload: {'screen': 'tickets'},));
  }

  @override
  Widget build(BuildContext context) {
    print("------------------------------");
    print(usuarioImagen);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
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
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
                Text(
                  "\nCrear un ticket para el \n departamento de recursos humanos",
                  style: GoogleFonts.croissantOne(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255)),
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
                                  child: usuarioImagen == ''  || usuarioImagen.isEmpty?
                                  const CircleAvatar(

                                    radius: 90,

                                    backgroundImage: AssetImage('assets/images/user.png'),

                                  ):
                                  CircleAvatar(

                                    radius: 90,

                                    backgroundImage: NetworkImage(usuarioImagen),

                                  )
                                  ,
                                ),
                                Text(
                                  "$usuarioPrimerNombre $usuarioPrimerApellido",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.archive,
                                        color: Colors.blueGrey, size: 18),
                                    Text(
                                      "Dep. $usuarioDepto",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueGrey),
                                    )
                                  ],
                                ),
                                const TextField(
                                  key: Key('campoAsunto'),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Asunto',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                                const SizedBox(height: 20),
                                const TextField(
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                      
                                      border: InputBorder.none,
                                      hintText: 'Ingrese una descripción de su ticket...',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 140,
                  child: ElevatedButton(
                    onPressed: triggerNotification,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 139, 194, 68)),
                    child: const Text('Enviar'),
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
