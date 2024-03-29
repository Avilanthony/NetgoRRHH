import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:recursos_humanos_netgo/main.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/new_view_noti.dart';
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
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late int usuarioID = 0;
  late String usuario = '';
  String usuarioNombre = '';
  String usuarioDepartamento = '';
  String usuarioRol = '';
  String? usuarioImagen;  // Cambiado de String a String?
  late SharedPreferences prefs;


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    usuario = jwtDecodedToken['uid'].toString();
    obtenerInformacionUsuario();
    initSharedPreferences();
    obtenerInformacionUsuario();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /* Future<void> verificarToken() async {
    try {
      bool tokenValido = !JwtDecoder.isExpired(widget.token);

      if (tokenValido) {
        Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
        usuario = jwtDecodedToken['uid'].toString();
        obtenerInformacionUsuario();
      } else {
        // Token vencido, navegar a la pantalla principal (MyHomePage)
        prefs.remove('token');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    } catch (error) {
      print('Error al verificar el token: $error');
    }
  }*/

   Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  } 

  Future<void> obtenerInformacionUsuario() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$dashboard/$usuario'), // Reemplaza con la URL correcta de tu backend
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        print("MyUsuario Dash: $myUsuario");

        setState(() {
          // Actualiza el estado con la información del usuario
          usuarioID = myUsuario['ID'];
          usuarioNombre = myUsuario['USUARIO'];
          usuarioRol = myUsuario['ROL'];
          usuarioDepartamento = myUsuario['DEPARTAMENTO'];
          usuarioImagen = myUsuario['IMAGEN'];
          print(usuarioID);
          print(usuarioNombre);
          print(usuarioRol);
          print(usuarioDepartamento);
          print(usuarioImagen);
          // Otros campos del usuario...
          /* _scaffoldKey.currentState!.setState(() {obtenerInformacionUsuario();}); */
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
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'RR-HH Netgo',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
               // Eliminar el token al cerrar sesión
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              // Navegar a la pantalla principal
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false, // Elimina todas las rutas del historial de navegación
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
                    builder: (context) => ViewNotiUser(token: widget.token)),
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
                          trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: (usuarioImagen != null)?
                              CircleAvatar(
              
                                radius: 55,
                                backgroundImage: NetworkImage(usuarioImagen!),
              
                              ):
                              const CircleAvatar(
              
                                radius: 55,
              
                                backgroundImage: AssetImage('assets/images/user.png'),
              
                              )
                              ,
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
          TicketsPage(token: widget.token),
          Documentos(token: widget.token),
          PerfilUsuario(token: widget.token),
          Settings(token: widget.token),
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
            _scaffoldKey.currentState!.setState(() {obtenerInformacionUsuario();});
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