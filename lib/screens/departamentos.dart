import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DepartamentViewScreen extends StatefulWidget {
  const DepartamentViewScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DepartamentViewScreen createState() => _DepartamentViewScreen();
}

class _DepartamentViewScreen extends State<DepartamentViewScreen> {
  List<String> departments = [
    'Contabilidad',
    'Recursos Humanos',
    'Ventas',
    'Tecnología de la Información',
    'Marketing',
    'Operaciones',
    'Desarrollo de Productos',
    'Servicio al Cliente'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'Departamentos',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(departments[index]),
            onTap: () {
              // Aquí puedes agregar la lógica para manejar la selección del departamento
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    String newDepartment = '';
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Agregar Departamento'),
            content: TextField(
              onChanged: (value) {
                newDepartment = value;
              },
              decoration: const InputDecoration(hintText: 'Nombre del departamento'),
            ),
            actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Agregar'),
            onPressed: () {
              if (newDepartment.isNotEmpty) {
                setState(() {
                  departments.add(newDepartment);
                });
              }
              Navigator.of(context).pop();
            },
          )
        ],
          );
        });
  }
}

