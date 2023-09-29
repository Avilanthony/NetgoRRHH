import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recursos_humanos_netgo/widgets/perfil_usuario.dart';
import 'package:recursos_humanos_netgo/widgets/tickets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/internet.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text('¡Hola Henry!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white)),
                      subtitle: Text('Bienvenido',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.white)),
                      trailing: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/papi.jpg'),
                      ),
                    ),
                  ],
                ),
              ),
              // Otros elementos de la lista aquí
            ],
          ),
        ],
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: const Color.fromARGB(255, 101, 166, 213),
        tabBackgroundColor: const Color.fromARGB(255, 26, 26, 26),
        gap: 7,
        tabs: [
          const GButton(
            icon: Icons.home,
            text: 'Inicio',
          ),
           GButton(
            icon: Icons.airplane_ticket_rounded,
            text: 'Ticket',
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TicketsPage()),
                );
              }
          ),
          const GButton(
            icon: Icons.picture_as_pdf_rounded,
            text: 'Documentos',
          ),
          GButton(
              icon: Icons.person,
              text: 'Perfil',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PerfilUsuario()),
                );
              }
              ),
        ],
      ),
    );
  }
}
