import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/new_detail_noti.dart';

class ViewNotiUser extends StatefulWidget {
  final token;

  const ViewNotiUser({@required this.token, Key? key}) : super(key: key);

  @override
  _ViewNotiUser createState() => _ViewNotiUser();
}

class _ViewNotiUser extends State<ViewNotiUser> {
  late String usuario = '';
  late List<dynamic> listaNotificaciones = [];

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    usuario = jwtDecodedToken['uid'].toString();
  }

  Future<List<dynamic>> obtenerInformacionNotificacion() async {
    try {
      final response = await http.get(
        Uri.parse('$ticket/ticket_noti/$usuario'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['usuario'];
      } else {
        // Manejar el error
        print('Error en la solicitud: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Manejar errores
      print('Error: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: const Text(
          'NOTIFICACIONES',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var nuevasNotificaciones = await obtenerInformacionNotificacion();
              setState(() {
                listaNotificaciones = nuevasNotificaciones;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: FutureBuilder(
        future: obtenerInformacionNotificacion(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            listaNotificaciones = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: ListView.builder(
                itemCount: listaNotificaciones.length,
                itemBuilder: (BuildContext context, int index) {
                  // Utiliza reversed aquí para mostrar la lista en orden inverso
                  var notificacion =
                      listaNotificaciones.reversed.toList()[index];
                  // Convertir la cadena de fecha de la base de datos a un objeto DateTime
                  DateTime fechaHora = DateTime.parse(notificacion['FECHA']);

                  // Convertir la fecha y hora a la zona horaria local
                  fechaHora = fechaHora.toLocal();

                  // Formatear la fecha y hora según tus preferencias
                  String fechaFormateada =
                      DateFormat('dd-MM-yyyy').format(fechaHora);
                  String horaFormateada =
                      DateFormat('hh:mm a').format(fechaHora);

                  return ListTile(
                    title: Text(
                      notificacion['ASUNTO'],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificacion['DETALLE'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 89, 89, 89),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$fechaFormateada $horaFormateada',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    leading: Container(
                      height: 40,
                      width: 70,
                      padding: const EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/Logo_Netgo.png"),
                          fit: BoxFit.cover,
                        ),
                        color: Color.fromARGB(255, 236, 237, 255),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewDetailsNotificationScreen(
                            notificacion: notificacion,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
