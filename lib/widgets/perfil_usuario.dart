import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recursos_humanos_netgo/widgets/dashboard.dart';
import 'package:recursos_humanos_netgo/widgets/documentos.dart';
import 'package:recursos_humanos_netgo/widgets/tickets.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'Perfil',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            const SizedBox(height: 25),
            itemPerfil('Anthony Avila', 'Nombre', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemPerfil('+504 9452-1396', 'Telefono', CupertinoIcons.phone),
            const SizedBox(height: 20),
            itemPerfil(
                'Tegucigalpa, Honduras', 'Localidad', CupertinoIcons.map),
            const SizedBox(height: 20),
            itemPerfil('Henry@Netgo.com', 'Correo', CupertinoIcons.mail),
            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shadowColor: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 81, 124, 193)),
                child: const Text('Editar Perfil'))
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
          color: const Color.fromARGB(179, 10, 47, 196).withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 10,
        ),
      ],
    ),
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(iconData),
      textColor: const Color.fromARGB(255, 0, 0, 0),
    ),
  );
}
