// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recursos_humanos_netgo/widgets/editar_perfil.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Text(
              "Perfil".toUpperCase(),
              style: GoogleFonts.croissantOne(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            const CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            const SizedBox(height: 20),
            itemPerfil('Anthony Avila', 'Nombre', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemPerfil('+504 9452-1396', 'Telefono', CupertinoIcons.phone),
            const SizedBox(height: 20),
            itemPerfil(
                'Tegucigalpa, Honduras', 'Localidad', CupertinoIcons.map),
            const SizedBox(height: 20),
            itemPerfil('Anthony@Netgo.com', 'Correo', CupertinoIcons.mail),
            const SizedBox(height: 20),
            /* ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shadowColor: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 81, 124, 193)),
                child: const Text('Editar Perfil')), */

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: EdgeInsets.only(top: 1.5, left: 1.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditarPerfilPage()));
                  },
                  color: Color.fromARGB(255, 81, 124, 193),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Editar Perfil",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /*bottomNavigationBar: GNav(
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
      ),*/
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
