import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<Map<String, dynamic>> users = [
  {
    'nombre': 'Juan',
    'apellido': 'Pérez',
    'departamento': 'Ventas',
    'activo': true
  },
  {
    'nombre': 'María',
    'apellido': 'Gómez',
    'departamento': 'Recursos Humanos',
    'activo': false
  },
  {
    'nombre': 'Henry',
    'apellido': 'Moncada',
    'departamento': 'Contabilidad',
    'activo': false
  },
  // Agrega más usuarios según tus necesidades
];

class GestionUsuariosPage extends StatefulWidget {
  @override
  _GestionUsuariosPage createState() => _GestionUsuariosPage();
}

class _GestionUsuariosPage extends State<GestionUsuariosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Registro de Usuarios",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                DataTable(
                  headingRowHeight: 40, // Altura de la fila de encabezado
                  dataRowHeight: 60, // Altura de las filas de datos

                  //columnSpacing: 16, // Espaciado entre columnas
                  columns: [
                    DataColumn(
                      label: Text(
                        'Nombre',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Departamento',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Estado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: users.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '${user['nombre']} ${user['apellido']}',
                          ),
                        ),
                        DataCell(
                          Text(
                            user['departamento'],
                          ),
                        ),
                        DataCell(
                          Center(
                            child: user['activo']
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.close, color: Colors.red),
                          ),
                          onTap: () {
                            // Agrega la lógica para cambiar el estado de la cuenta del usuario.
                            setState(() {
                              user['activo'] = !user[
                                  'activo']; // Cambiar el estado al contrario (activo a inactivo o viceversa).
                            });
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
