import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/adjuntar_boleta.dart';

class GestionarBoletaPage extends StatefulWidget {
  const GestionarBoletaPage({super.key});
  @override
  _GestionarBoletaPageState createState() => _GestionarBoletaPageState();
}

class _GestionarBoletaPageState extends State<GestionarBoletaPage> {
  //const _GestionarBoletaPageState({Key? key}) : super(key: key);

  _GestionarBoletaPageState() {
    _valorSelec = _departamentosUsuario[0];
  }

  //String dropdownValue = 'Todos';
  final _departamentosUsuario = [
    "All",
    "Marketing",
    "Administrración",
    "RRHH",
    "Mantenimiento"
  ];
  String? _valorSelec = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          backgroundColor: Colors.white,
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
                            "Seleccionar Usuarios",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Selecciona el departamento al que quieres gestionar",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: DropdownButtonFormField(
                              value: _valorSelec,
                              items: _departamentosUsuario
                                  .map((e) => DropdownMenuItem(
                                        
                                    value: e,
                                    child: Text(e),
                                  ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _valorSelec = val as String;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Color.fromARGB(255, 81, 124, 193),
                              ),
                              dropdownColor:
                                  const Color.fromARGB(255, 231, 241, 246),
                              decoration: const InputDecoration(
                                labelText: "Elige un Departamento",
                                prefixIcon: Icon(
                                  CupertinoIcons.briefcase_fill,
                                  color: Color.fromARGB(255, 81, 124, 193),
                                ),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Selecciona el usuario al que le quieras adjuntar su boleta de pago",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                              textAlign: TextAlign.center,
                            ),
                            
                          ),
                          const SizedBox(height: 15),

                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(

                              children: <Widget>[

                                itemUsuarios('Anthony Avila', 'Contabilidad', context),
                                itemUsuarios('Adoniss Ponce', 'Contabilidad', context),
                                itemUsuarios('Henry Cabrera', 'Contabilidad', context),

                              ]

                            )),

                          const Padding(
                            padding:  EdgeInsets.all(20),
                            child: Column(

                              //itemUsuarios('Anthony Avila', 'Contabilidad',),

                            )
                          ),
                          
                        ],
                      )
                    ]
                  )
                )
              )
            )
          );
  }
}

itemUsuarios(String nombreComp, String depart, context) {
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
              subtitle: Text(depart,
              style: TextStyle(
                fontSize: 15, color: Colors.grey[700])),
              
              textColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            Positioned(
              top: 10,
              bottom: 10,
              right: 10,
              child: Container(
                width: 130,
                child: ElevatedButton(
                          //minWidth: double.infinity,
                          //height: 0,
                          onPressed: () {
                             Navigator.push(
                              context, MaterialPageRoute(builder: (context) => AdjuntarBoletaPage()));
                              
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 81, 124, 193), // Cambia el color del botón a rojo
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25), // Bordes redondeados
                            ),
                          ),
                          //: Color.fromARGB(255, 81, 124, 193),
                          //elevation: 0,
                          child: const Text(
                            "Adjuntar",
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
