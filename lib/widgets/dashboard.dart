import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recursos_humanos_netgo/widgets/documentos.dart';
import 'package:recursos_humanos_netgo/widgets/perfil_usuario.dart';
import 'package:recursos_humanos_netgo/widgets/tickets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'App RR-HH Netgo',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 81, 124, 193),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        '¡Hola Anthony!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Bienvenido',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      trailing: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        radius: 30,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          backgroundColor: Colors.black,
                          radius: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Otros elementos de la lista aquí
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Personaje3.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
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
