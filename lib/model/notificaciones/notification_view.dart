import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recursos_humanos_netgo/blocs/notifications/notifications_bloc.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/details_notification.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
            text: 'NOTIFICACIONES',
            style: GoogleFonts.josefinSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationsBloc>().requestPermission();
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<NotificationsBloc>().state.notifications;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10), // Ajusta este valor según tus necesidades
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (BuildContext context, int index) {
            final notification = notifications[index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.body),
                  SizedBox(height: 5),
                  Text(
                    'Fecha y hora: ${notification.sentDate}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              leading: Container(
                height: 50,
                width: 80,
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/Logo_Netgo.png"),
                    fit: BoxFit.cover,
                  ),
                  color: const Color.fromARGB(255, 236, 237, 255),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsNotificationScreen(
                      pushMessageId: notification.messageId,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

