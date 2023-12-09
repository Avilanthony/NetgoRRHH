import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/model/dashboard/documentos_screens/boleta.dart';
import 'package:recursos_humanos_netgo/model/dashboard/documentos_screens/constancia.dart';
import 'package:recursos_humanos_netgo/model/dashboard/documentos_screens/dni.dart';
import 'package:recursos_humanos_netgo/model/dashboard/documentos_screens/vacaciones.dart';
import 'package:url_launcher/url_launcher.dart';

class Documentos extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const Documentos({@required this.token, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Documentos createState() => _Documentos();
}

late String _token; // Variable para almacenar el token
final websiteUrl =
      Uri.parse('https://sites.google.com/view/loginrrhh/acceso?authuser=0');

class _Documentos extends State<Documentos> {
  late String usuario = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
    _token = widget.token; // Almacenar el token en la variable _token
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
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
            const SizedBox(height: 20),
            itemPerfilUrl(
              'Pagina Web',
              '',
              CupertinoIcons.macwindow,""
            ),
            const SizedBox(height: 25),
            itemPerfil('DNI', '', CupertinoIcons.person_alt_circle, context),
            const SizedBox(height: 20),
            itemPerfil('Contancia', '', CupertinoIcons.doc, context),
            const SizedBox(height: 20),
            itemPerfil('Vacaciones', '', CupertinoIcons.sun_dust, context),
            const SizedBox(height: 20),
            itemPerfil('Boleta de pago', '', CupertinoIcons.doc_chart, context),
          ],
        ),
      ),
    );
  }
}

itemPerfil(
    String title, String subtitle, IconData iconData, BuildContext context) {
  return GestureDetector(
    onTap: () {
      switch (title) {
        case 'DNI':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ImagenDniPage()),
          );
          break;
        case 'Contancia':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConstanciaPdfViewerScreen(token: _token)),
          );
          break;
        case 'Vacaciones':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VacationRequestScreen(token: _token)),
          );
          break;
        case 'Boleta de pago':
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BoletaPdfViewerScreen()),
          );
          break;
        default:
          break;
      }
    },
    child: Container(
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
        leading: Icon(iconData),
        iconColor: const Color.fromARGB(255, 81, 124, 193),
        trailing: const Icon(Icons.arrow_forward,
            color: Color.fromARGB(255, 81, 124, 193)),
        textColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    ),
  );
}

Widget itemPerfilUrl(
  String title, String subtitle, IconData iconData, String url) {
  return GestureDetector(
    onTap: () {
      launchUrl(
        websiteUrl,
        mode: LaunchMode.inAppWebView,
      );
    },
    child: Container(
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
        leading: Icon(iconData),
        iconColor: const Color.fromARGB(255, 81, 124, 193),
        trailing: const Icon(Icons.arrow_forward,
            color: Color.fromARGB(255, 81, 124, 193)),
        textColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    ),
  );
}

