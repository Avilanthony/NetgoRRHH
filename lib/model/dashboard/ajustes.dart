import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/editables.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/gestion_usuarios.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/notificacion_personal.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
                      itemSettings('Editables', CupertinoIcons.building_2_fill,
                          Colors.black, context),
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
                builder: (context) => const PersonalNotificationScreen()),
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
