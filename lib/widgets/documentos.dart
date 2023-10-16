// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Documentos extends StatelessWidget {
  const Documentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Documentos".toUpperCase(),
              style: GoogleFonts.croissantOne(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 25),
            itemPerfil('DNI', '', CupertinoIcons.person_alt_circle, ""),
            const SizedBox(height: 20),
            itemPerfil('Contancia', '', CupertinoIcons.doc, ""),
            const SizedBox(height: 20),
            itemPerfil('Vacaciones', '', CupertinoIcons.sun_dust, ""),
            const SizedBox(height: 20),
            itemPerfil('Contrato', '', CupertinoIcons.doc_person, ""),
            const SizedBox(height: 20),
            itemPerfil('Boleta de pago', '', CupertinoIcons.doc_chart, ""),
            const SizedBox(height: 20),
            itemPerfil('Notificaciones Generales', '', CupertinoIcons.bell, ""),
            const SizedBox(height: 20),
            itemPerfil('Pagina Web', '', CupertinoIcons.macwindow, 'https://netgogroup.com/'),
          ],
        ),
      ),
    );
  }
}

Widget itemPerfil(String title, String subtitle, IconData iconData, String url) {
  return GestureDetector(
    onTap: () async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'No se pudo abrir la URL: $url';
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: const Color.fromARGB(146, 17, 0, 255).withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        leading: Icon(iconData),
        iconColor: const Color.fromARGB(255, 81, 124, 193),
        trailing: const Icon(Icons.arrow_forward,
            color: Color.fromARGB(255, 81, 124, 193)),
        textColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    ),
  );
}
