import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recursos_humanos_netgo/blocs/notifications/notifications_bloc.dart';
import 'package:recursos_humanos_netgo/domain/entities/push_message.dart';

class DetailsNotificationScreen extends StatelessWidget {
  final String pushMessageId;

  const DetailsNotificationScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.watch<NotificationsBloc>().getMessageById(pushMessageId);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: Text.rich(
            TextSpan(
                text: 'Detalle Notificación',
                style: GoogleFonts.josefinSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 237, 255),
        body: (message != null)
            ? _DetailsView(message: message)
            : const Center(child: Text('Notificación no existe')));
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage message;

  const _DetailsView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          /* if ( message.imageUrl != null ) 
            Image.network(message.imageUrl!), */
          Container(
            height: 150, // ajusta el valor según tu preferencia
            width: 300, // ajusta el valor según tu preferencia
            margin: const EdgeInsets.all(0),
            child: Image.asset(
              "assets/images/Logo_Netgo.png",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 10),

          //Remitente de la notificacion
          Text(
            'ENVIADO POR:',
            style: GoogleFonts.josefinSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.center,
          ),
          Text(
            '${message.messageId}!',
            style: GoogleFonts.josefinSans(
                fontSize: 18,
                //fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),

          //Asunto de la notificacion
          Text(
            'ASUNTO:',
            style: GoogleFonts.josefinSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.center,
          ),
          Text(
            '${message.title}!',
            style: GoogleFonts.josefinSans(
                fontSize: 18,
                //fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 8),

          //Asunto de la notificacion
          Text(
            'DESCRIPCIÓN:',
            style: GoogleFonts.josefinSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.center,
          ),
          Text(
            '${message.body}!',
            style: GoogleFonts.josefinSans(
                fontSize: 18,
                //fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 8),

          Text(
            'Fecha y hora: ${message.sentDate}',
            style: const TextStyle(
                fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      ),
    );
  }
}
