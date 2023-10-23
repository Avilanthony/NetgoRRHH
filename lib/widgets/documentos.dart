import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recursos_humanos_netgo/screens/constancia.dart';
import 'package:recursos_humanos_netgo/screens/contrato.dart';
import 'package:recursos_humanos_netgo/screens/dni.dart';
import 'package:recursos_humanos_netgo/screens/vacaciones.dart';
import 'package:recursos_humanos_netgo/widgets/perfil_usuario.dart';
import 'package:url_launcher/url_launcher.dart';


class Documentos extends StatelessWidget {
  const Documentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            itemPerfilUrl('Pagina Web', '', CupertinoIcons.macwindow, 'https://netgogroup.com/'),
            const SizedBox(height: 25),
            itemPerfil('DNI', '', CupertinoIcons.person_alt_circle, context),
            const SizedBox(height: 20),
            itemPerfil('Contancia', '', CupertinoIcons.doc, context),
            const SizedBox(height: 20),
            itemPerfil('Vacaciones', '', CupertinoIcons.sun_dust, context),
            const SizedBox(height: 20),
            itemPerfil('Contrato', '', CupertinoIcons.doc_person, context),
            const SizedBox(height: 20),
            itemPerfil('Boleta de pago', '', CupertinoIcons.doc_chart, context),
          ],
        ),
      ),
    );
  }
}

itemPerfil(String title, String subtitle, IconData iconData, BuildContext context) {
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
            MaterialPageRoute(builder: (context) => const ConstanciaPdfViewerScreen()),
          );
          break;
          case 'Vacaciones':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VacationRequestScreen()),
          );
          break;
          case 'Contrato':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContratoPdfViewerScreen()),
          );
          break;
          case 'Boleta de pago':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PerfilUsuario()),
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

Widget itemPerfilUrl(String title, String subtitle, IconData iconData, String url) {
  return GestureDetector(
    onTap: () async {
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        throw 'No se pudo abrir la URL: $url';
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