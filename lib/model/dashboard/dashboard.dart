import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/notification_view.dart';
import 'package:recursos_humanos_netgo/model/dashboard/documentos.dart';
import 'package:recursos_humanos_netgo/model/dashboard/perfil_screens/perfil_usuario.dart';
import 'package:recursos_humanos_netgo/model/dashboard/tickets.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class Dashboard extends StatefulWidget {
  final token;
  const Dashboard({@required this.token, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  late String usuario = '';

  @override
  void initState(){
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'RR-HH Netgo',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              // Lógica para cerrar sesión aquí
              // Puedes navegar a la pantalla de inicio de sesión o realizar otras acciones necesarias.
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationView()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Stack(
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
                            '¡Hola $usuario!',
                            style: GoogleFonts.josefinSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'Bienvenido',
                            style: GoogleFonts.josefinSans(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          trailing: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
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
          const TicketsPage(),
          const Documentos(),
          const PerfilUsuario(),
          const Settings(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 81, 124, 193),
        ),
        child: GNav(
          backgroundColor: const Color.fromARGB(255, 81, 124, 193),
          color: Colors.white,
          activeColor: const Color.fromARGB(255, 255, 255, 255),
          tabBackgroundColor: const Color.fromARGB(255, 115, 150, 207),
          gap: 0,
          iconSize: 20,
          textStyle: GoogleFonts.josefinSans(fontSize: 13, color: Colors.white),
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Inicio',
            ),
            GButton(
              icon: Icons.airplane_ticket_rounded,
              text: 'Ticket',
            ),
            GButton(
              icon: LineAwesomeIcons.file,
              text: 'Archivos',
            ),
            GButton(
              icon: Icons.person,
              text: 'Perfil',
            ),
            GButton(
              icon: LineAwesomeIcons.cog,
              text: 'Ajustes',
            ),
          ],
        ),
      ),
    );
  }
}
