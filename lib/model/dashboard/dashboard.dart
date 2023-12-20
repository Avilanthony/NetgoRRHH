import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:recursos_humanos_netgo/main.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/notification_view.dart';
import 'package:recursos_humanos_netgo/model/dashboard/documentos.dart';
import 'package:recursos_humanos_netgo/model/dashboard/perfil_screens/perfil_usuario.dart';
import 'package:recursos_humanos_netgo/model/dashboard/tickets.dart';
import 'package:http/http.dart' as http;

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final token;
  const Dashboard({@required this.token, Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  late int usuarioID = 0;
  late String usuario = '';
  String usuarioNombre = '';
  String usuarioDepartamento = '';
  String usuarioRol = '';
  String usuarioImagen = '';
  late SharedPreferences prefs;

  // Agrega esta línea
  final GlobalKey<_DashboardState> dashboardKey = GlobalKey<_DashboardState>();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    usuario = jwtDecodedToken['uid'].toString();
    obtenerInformacionUsuario();
    initSharedPreferences();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> obtenerInformacionUsuario() async {
    try {
      final response = await http.get(
        Uri.parse('$dashboard/$usuario'),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        print("MyUsuario Dash: $myUsuario");

        setState(() {
          usuarioID = myUsuario['ID'];
          usuarioNombre = myUsuario['USUARIO'];
          usuarioRol = myUsuario['ROL'];
          usuarioDepartamento = myUsuario['DEPARTAMENTO'];
          usuarioImagen = myUsuario['IMAGEN'];
        });

        // Agrega esta línea para reconstruir la pantalla
        dashboardKey.currentState?.setState(() {});
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    dashboardKey.currentState?.setState(() {});
    print("------------------------------");
    print(usuarioImagen);
    return Scaffold(
      key: dashboardKey, // Agrega esta línea
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
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false,
              );
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
        physics: const NeverScrollableScrollPhysics(),
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
                          trailing: usuarioImagen == '' || usuarioImagen.isEmpty
                              ? const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                    backgroundColor: Colors.black,
                                    radius: 25,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(usuarioImagen),
                                ),
                        ),
                      ],
                    ),
                  ),
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
          TicketsPage(token: widget.token),
          Documentos(token: widget.token),
          PerfilUsuario(token: widget.token),
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
