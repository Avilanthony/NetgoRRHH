import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
/* import 'package:downloads_path_provider_28/downloads_path_provider_28.dart'; */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:recursos_humanos_netgo/services/notificacion_pdf_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages

class BoletaScreen extends StatefulWidget {
  final int usuarioId;
  final token;
  const BoletaScreen(
      {Key? key, required this.usuarioId, required this.token})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BoletaScreenState createState() => _BoletaScreenState();
}

class _BoletaScreenState extends State<BoletaScreen> {
  late String usuarioBoleta = '';
  late String usuario = '';
  String pdfurl = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    usuario = jwtDecodedToken['uid'].toString();
    NotificationService().initNotification();
    obtenerInformacionUsuario();
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
          usuarioBoleta = myUsuario['BOLETA'];
          print(usuarioBoleta);
          pdfurl = usuarioBoleta;
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
      appBar: AppBar(
        title: Text('Boleta de Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              color: const Color.fromARGB(255, 6, 82, 144),
              child: const Row(
                children:[
                  Expanded(
                    child: Text(
                      'COMPROBANTE DE PAGO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            /* =================================================================================== */
            Container(
              height: 25,
              color: const Color.fromARGB(255, 6, 82, 144),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Datos de la Empresa',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nombre:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el nombre
                                "NETGO GROUP S DE R.L.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 130, // Ancho deseado para la imagen
                  height: 70, // Altura deseada para la imagen
                  child: Image.asset(
                    'assets/images/Logo_Netgo.png', 
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'RTN:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el RTN
                                "08019012466398",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            /* =================================================================================== */
            Container(
              height: 25,
              color: const Color.fromARGB(255, 6, 82, 144),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Datos del Empleado',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nombre:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el nombre
                                "ISAAC DAVID LUQUE MEDINA",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Fecha de Ingreso:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el RTN
                                "26/3/22",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Puesto:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el nombre
                                "DESARROLLADOR",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Departamento:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el RTN
                                "MARKETING",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            /* =================================================================================== */
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100, // Ancho deseado para la columna "Quincena"
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        color: const Color.fromARGB(255, 6, 82, 144),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Quincena:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Segunda Quincena de Septiembre 2022',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100, // Ancho deseado para la columna "Quincena"
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        color: const Color.fromARGB(255, 6, 82, 144),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'DNI:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            '0801199910865',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
             /* =================================================================================== */
            Container(
              height: 25,
              color: const Color.fromARGB(255, 6, 82, 144),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Datos del Salario',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Sueldo Mensual:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el nombre
                                "L. 20,000.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Sueldo Quincenal',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el RTN
                                "L. 10,000.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Horas Trabajadas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el RTN
                                "30",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            /* =================================================================================== */
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        color: const Color.fromARGB(255, 6, 82, 144),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ingresos:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el nombre
                                "L. 15,000.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el RTN
                                "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        color: const Color.fromARGB(255, 6, 82, 144),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Deducciones:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 246, 254),
                          border: Border.all(
                            color: Colors.black
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el nombre
                                "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                ':',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                // Dato donde irá el RTN
                                "L. 20,000.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text(
              'Ingresos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Ingresos
            const SizedBox(height: 20),
            const Text(
              'Deducciones',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Deducciones
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Ingresos:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Valor de los ingresos totales
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Deducciones:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Valor del total de deducciones
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Valor Neto Recibido:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Valor del valor neto recibido
              ],
            ),
          ],
        ),
      ),
    );
  }
}
