import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text.rich(
          TextSpan(
              text: 'RR-HH Netgo - Perfil',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage('assets/images/papi.jpg'),
            ),
            const SizedBox(height: 25),
            itemPerfil('Henry Cavil', 'Nombre', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemPerfil('+504 9452-1396', 'Telefono', CupertinoIcons.phone),
            const SizedBox(height: 20),
            itemPerfil(
                'Localidad', 'Tegucigalpa, Honduras', CupertinoIcons.map),
            const SizedBox(height: 20),
            itemPerfil('Henry@Netgo.com', 'Correo', CupertinoIcons.mail),
            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shadowColor: Colors.black,
                    backgroundColor: Colors.black),
                child: const Text('Editar Perfil'))
          ],
        ),
      ),
      bottomNavigationBar: const GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Color.fromARGB(255, 101, 166, 213),
        tabBackgroundColor: Color.fromARGB(255, 26, 26, 26),
        gap: 7,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Inicio',
          ),
          GButton(
            icon: Icons.airplane_ticket_rounded,
            text: 'Ticket',
          ),
          GButton(
            icon: Icons.picture_as_pdf_rounded,
            text: 'Documentos',
          ),
          GButton(
            icon: Icons.person,
            text: 'Perfil',
          ),
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
      trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
      textColor: const Color.fromARGB(255, 0, 0, 0),
    ),
  );
}

/*class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromARGB(128, 220, 204, 204),
        ),
        child: Icon(icon, color: const Color.fromARGB(255, 30, 0, 255)),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255, 117, 107, 107).withOpacity(0.1)),
        child: const Icon(LineAwesomeIcons.angle_right,
            size: 18.0, color: Colors.grey),
      ),
    );
  }
}*/

/*SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                      image: AssetImage('assets/images/scarleth.png')),
                ),
              ),
              const SizedBox(height: 25),
              Text.rich(
                TextSpan(
                    text: 'Scarleth Baquedano',
                    style: GoogleFonts.josefinSans(
                        fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Text.rich(
                TextSpan(
                    text: 'Nombre\n',
                    style: GoogleFonts.josefinSans(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 25),
              Text.rich(
                TextSpan(
                    text: 'abigail@correo.com',
                    style: GoogleFonts.josefinSans(
                        fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Text.rich(
                TextSpan(
                    text: 'Correo\n',
                    style: GoogleFonts.josefinSans(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('EditarPerfil'),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //MENU
              ProfileMenuWidget(title: "Ajustes", icon: LineAwesomeIcons.cog, onPressed: (){}),
              ProfileMenuWidget(title: "Ajustes", icon: LineAwesomeIcons.cog, onPressed: (){}),
              ProfileMenuWidget(title: "Ajustes", icon: LineAwesomeIcons.cog, onPressed: (){}),
              ProfileMenuWidget(title: "Ajustes", icon: LineAwesomeIcons.cog, onPressed: (){}),
              ProfileMenuWidget(title: "Detalles", icon: LineAwesomeIcons.cog, onPressed: (){}),
              ProfileMenuWidget(title: "Ajustes", icon: LineAwesomeIcons.cog, onPressed: (){}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Información", icon: LineAwesomeIcons.cog, onPressed: (){}),
              ProfileMenuWidget(
                title: "Salir", 
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPressed: (){}),
            ],
          ),
        ),
      ),*/