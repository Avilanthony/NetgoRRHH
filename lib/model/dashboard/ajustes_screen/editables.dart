import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/departamentos.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/locales.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/roles.dart';

class EditsViewScreen extends StatefulWidget {
  const EditsViewScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _EditsViewScreen createState() => _EditsViewScreen();
}

class _EditsViewScreen extends State<EditsViewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: const Color.fromARGB(255, 236, 237, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      "Seleccione una opción",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Selecciona el apartado en el que quiera agregar o eliminar una opción.",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          itemUsuarios('Departamentos', context),
                          itemUsuarios('Roles', context),
                          itemUsuarios('Locales', context),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

itemUsuarios(String nombreComp, context) {
  return Column(
    children: <Widget>[
      Container(
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
        child: Stack(
          children: [
            ListTile(
              title: Text(nombreComp),
              textColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            Positioned(
              top: 10,
              bottom: 10,
              right: 10,
              child: SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla específica según la opción seleccionada
                    _navigateToSpecificScreen(nombreComp, context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 81, 124, 193),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Editar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}

// Función para navegar a la pantalla específica según la opción seleccionada
void _navigateToSpecificScreen(String nombreComp, BuildContext context) {
  if (nombreComp == 'Departamentos') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DepartamentViewScreen(),
      ),
    );
  } else if (nombreComp == 'Roles') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RolesViewScreen(),
      ),
    );
  } else if (nombreComp == 'Locales') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocalViewScreen(),
      ),
    );
  }
  // Puedes agregar más condiciones según sea necesario para otros usuarios
}

