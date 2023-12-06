import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/notification_view.dart';
import 'package:recursos_humanos_netgo/model/dashboard/documentos.dart';
import 'package:recursos_humanos_netgo/model/dashboard/perfil_screens/perfil_usuario.dart';
import 'package:recursos_humanos_netgo/model/dashboard/tickets.dart';
import 'package:http/http.dart' as http;

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
  String usuarioNombre = '';
  String usuarioDepartamento = '';
  String usuarioRol = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
    obtenerInformacionUsuario();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> obtenerInformacionUsuario() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$dashboard/$usuario'), // Reemplaza con la URL correcta de tu backend
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        setState(() {
          // Actualiza el estado con la información del usuario
          usuarioNombre = myUsuario['USUARIO'];
          usuarioRol = myUsuario['ROL'];
          usuarioDepartamento = myUsuario['DEPARTAMENTO'];
          print(usuarioNombre);
          print(usuarioRol);
          print(usuarioDepartamento);
          // Otros campos del usuario...
        });
      } else {
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja errores de red u otros errores aquí
      print('Error: $error');
    }
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
        physics: const NeverScrollableScrollPhysics(), // Deshabilitar deslizamiento
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
                            '¡Hola $usuarioNombre!',
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
          tabs: [
            const GButton(
              icon: Icons.home,
              text: 'Inicio',
            ),
            const GButton(
              icon: Icons.airplane_ticket_rounded,
              text: 'Ticket',
            ),
            const GButton(
              icon: LineAwesomeIcons.file,
              text: 'Archivos',
            ),
            const GButton(
              icon: Icons.person,
              text: 'Perfil',
            ),
            if (usuarioRol == "ADMIN" && usuarioDepartamento == "RRHH")
              const GButton(
                icon: LineAwesomeIcons.cog,
                text: 'Ajustes',
              ),
          ],
        ),
      ),
    );
  }
}
