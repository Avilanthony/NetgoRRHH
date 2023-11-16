import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPage();
}

class _TicketsPage extends State<TicketsPage> {

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
                const TicketWidget(
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
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                    backgroundColor: Color.fromARGB(255, 172, 172, 172),
                                    radius: 55,
                                  ),
                                ),
                                Text(
                                  "Anthony Avila",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.archive,
                                        color: Colors.blueGrey, size: 18),
                                    Text(
                                      'Dep. TI',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueGrey),
                                    )
                                  ],
                                ),
                                TextField(
                                  key: Key('campoAsunto'),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Asunto',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                                SizedBox(height: 20),
                                TextField(
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
