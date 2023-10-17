import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            color: const Color.fromARGB(255, 192, 195, 255),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Ajustes".toUpperCase(),
                    style: GoogleFonts.croissantOne(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    itemSettings('Usuarios', CupertinoIcons.person_2_fill,
                        Colors.black),
                    itemSettings(
                        'Notificar', CupertinoIcons.bell, Colors.black),
                    itemSettings('Permisos', CupertinoIcons.person_2_fill,
                        Colors.black),
                    itemSettings('Usuarios', CupertinoIcons.person_2_fill,
                        Colors.black),
                    itemSettings('Usuarios', CupertinoIcons.person_2_fill,
                        Colors.black),
                    itemSettings('Usuarios', CupertinoIcons.person_2_fill,
                        Colors.black),
                    itemSettings('Usuarios', CupertinoIcons.person_2_fill,
                        Colors.black),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

itemSettings(String title, IconData iconData, Color background) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          offset: Offset(5, 5),
          color: Color.fromARGB(128, 12, 62, 181),
          spreadRadius: 2,
          blurRadius: 5,
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            color: Colors.white,
            size: 35,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.breeSerif(fontSize: 20, color: Colors.blue),
        ),
      ],
    ),
  );
}
