import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalViewScreen extends StatefulWidget {
  const LocalViewScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LocalViewScreen createState() => _LocalViewScreen();
}

class _LocalViewScreen extends State<LocalViewScreen> {
  List<String> departments = [
    'Tegucigalpa',
    'San Pedro Sula',
    'Ceiba',
  ];

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
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text(
                    "Localidades",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "En este apartado puede agregar o eliminar la localidad que quiera.",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        for (var department in departments)
                          itemUsuarios(department, context),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _displayDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 81, 124, 193),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Agregar Nuevo",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
                      _removeDepartment(nombreComp);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 211, 48, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Eliminar",
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

  _displayDialog(BuildContext context) async {
    String newDepartment = '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Localidad'),
          content: TextField(
            onChanged: (value) {
              newDepartment = value;
            },
            decoration: const InputDecoration(
                hintText: 'Localidad'),
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
            ),
          ],
        );
      },
    );
  }

  _removeDepartment(String department) {
    setState(() {
      departments.remove(department);
    });
  }
}
