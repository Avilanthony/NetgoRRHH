// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalNotificationScreen extends StatefulWidget {
  const PersonalNotificationScreen({Key? key}) : super(key: key);

  @override
  _PersonalNotificationScreenState createState() =>
      _PersonalNotificationScreenState();
}

class _PersonalNotificationScreenState
    extends State<PersonalNotificationScreen> {
  String dropdownValue = 'Todos';
  bool showDepartmentDropdown = false;
  bool showPersonDropdown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'Enviar notificación',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                "Notificar".toUpperCase(),
                style: GoogleFonts.croissantOne(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 81, 124, 193),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: showDepartmentDropdown,
                    onChanged: (value) {
                      setState(() {
                        showDepartmentDropdown = value!;
                        showPersonDropdown = false;
                      });
                    },
                  ),
                  const Text('Por departamento'),
                ],
              ),
              if (showDepartmentDropdown)
                Column(
                  children: [
                    const SizedBox(height: 5),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      underline: Container(
                        height: 2,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Todos',
                        'Contabilidad',
                        'TI',
                        'Soporte',
                        'Ventas'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              Row(
                children: [
                  Checkbox(
                    value: showPersonDropdown,
                    onChanged: (value) {
                      setState(() {
                        showPersonDropdown = value!;
                        showDepartmentDropdown = false;
                      });
                    },
                  ),
                  const Text('Por Usuario'),
                ],
              ),
              if (showPersonDropdown)
                Column(
                  children: [
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: const TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Nombre de Usuario',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Text(
                "Asunto:",
                style: GoogleFonts.croissantOne(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 0),
              Container(
                padding: const EdgeInsets.all(15),
                child: const TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Asunto de la notificación...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Notificación:",
                style: GoogleFonts.croissantOne(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 0),
              Container(
                padding: const EdgeInsets.all(15),
                child: const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Descripción de la notificación...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 0),
              SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 81, 124, 193),
                  ),
                  child: const Text('Enviar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
