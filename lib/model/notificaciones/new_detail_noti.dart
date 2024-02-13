import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewDetailsNotificationScreen extends StatelessWidget {
  final dynamic notificacion;

  const NewDetailsNotificationScreen({
    Key? key,
    required this.notificacion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text.rich(
          TextSpan(
            text: 'Detalle Notificación',
            style: GoogleFonts.josefinSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: _DetailsView(notificacion: notificacion),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final dynamic notificacion;

  const _DetailsView({required this.notificacion});

  @override
  Widget build(BuildContext context) {
    // Convertir la cadena de fecha de la base de datos a un objeto DateTime
    DateTime fechaHora = DateTime.parse(notificacion['FECHA']);

    // Convertir la fecha y hora a la zona horaria local
    fechaHora = fechaHora.toLocal();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 300,
            margin: const EdgeInsets.all(0),
            child: Image.asset(
              "assets/images/Logo_Netgo.png",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'ENVIADO POR:',
            style: GoogleFonts.josefinSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${notificacion['P_NOMBRE']} ${notificacion['S_NOMBRE']} ${notificacion['P_APELLIDO']} ${notificacion['S_APELLIDO']}',
            style: GoogleFonts.josefinSans(
              fontSize: 18,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'DEPARTAMENTO:',
            style: GoogleFonts.josefinSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${notificacion['DEPARTAMENTO']}',
            style: GoogleFonts.josefinSans(
              fontSize: 18,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 0),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'ASUNTO:',
            style: GoogleFonts.josefinSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${notificacion['ASUNTO']}',
            style: GoogleFonts.josefinSans(
              fontSize: 18,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'DESCRIPCIÓN:',
            style: GoogleFonts.josefinSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${notificacion['DETALLE']}',
            style: GoogleFonts.josefinSans(
              fontSize: 18,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Fecha y hora: ${DateFormat('dd-MM-yyyy hh:mm a').format(fechaHora)}',
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
