import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recursos_humanos_netgo/widgets/dashboard.dart';
import 'package:recursos_humanos_netgo/widgets/perfil_usuario.dart';
import 'package:recursos_humanos_netgo/widgets/tickets.dart';

class Documentos extends StatelessWidget {
  const Documentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'Documentos',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          textAlign: TextAlign.center,
        ),
      ),
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
            itemPerfil('DNI', '', CupertinoIcons.person_alt_circle),
            const SizedBox(height: 20),
            itemPerfil('Contancia', '', CupertinoIcons.doc),
            const SizedBox(height: 20),
            itemPerfil('Vacaciones', '', CupertinoIcons.sun_dust),
            const SizedBox(height: 20),
            itemPerfil('Informe', '', CupertinoIcons.doc_append),
            const SizedBox(height: 20),
            itemPerfil('Contrato', '', CupertinoIcons.doc_person),
            const SizedBox(height: 20),
            itemPerfil('Boleta de pago', '', CupertinoIcons.doc_chart),
          ],
        ),
      ),
      bottomNavigationBar: GNav(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        color: Colors.white,
        activeColor: const Color.fromARGB(255, 255, 255, 255),
        tabBackgroundColor: const Color.fromARGB(255, 115, 150, 207),
        gap: 7,
        tabs: [
          GButton(
              icon: Icons.home,
              text: 'Inicio',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              }),
          GButton(
              icon: Icons.airplane_ticket_rounded,
              text: 'Ticket',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TicketsPage()),
                );
              }),
          GButton(
              icon: Icons.picture_as_pdf_rounded,
              text: 'Documentos',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Documentos()),
                );
              }),
          GButton(
              icon: Icons.person,
              text: 'Perfil',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PerfilUsuario()),
                );
              }),
        ],
      ),
    );
  }
}

itemPerfil(String title, String subtitle, IconData iconData) {
  return Container(
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
      leading: Icon(iconData) ,
      iconColor: const Color.fromARGB(255, 81, 124, 193),
      trailing: const Icon(Icons.arrow_forward, color: Color.fromARGB(255, 81, 124, 193)),
      textColor: const Color.fromARGB(255, 0, 0, 0),
    ),
  );
}
