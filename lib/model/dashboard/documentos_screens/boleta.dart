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
/* import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; */
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
  Map<String, dynamic> _datosBoletaUsuario = {};
  final formatter = NumberFormat.currency(locale: 'es_HN', symbol: 'L.', customPattern: '\u00A4 #,##0.00');
  

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
            '$boleta/boleta_usuario/$usuario'), // Reemplaza con la URL correcta de tu backend
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        final data = json.decode(response.body);
        final detallesUsuario = data['usuario']; 

        print(jsonResponse);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        print("MyUsuario Boleta: $myUsuario");
        print("==================================================");

        setState(() {
          // Actualiza el estado con la información del usuario
          _datosBoletaUsuario = detallesUsuario;
        });
        
        print('Detalles del usuario: $data');
        print("Esto es una prueba: $_datosBoletaUsuario");
        print(_datosBoletaUsuario['NOMBRE_COMPLETO']);
        print(formatter.format(_datosBoletaUsuario['SUELDO_MENSUAL']));

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Boleta de Pago'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black
              ),
              
            ),
            width: double.infinity,
            child: SingleChildScrollView(
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
                                color: const Color.fromARGB(255, 220, 228, 235),
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
                                color: const Color.fromARGB(255, 220, 228, 235),
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
                                color: const Color.fromARGB(255, 220, 228, 235),
                                border: Border.all(
                                  color: Colors.black
                                )
                              ),
                              child:  Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                     ((_datosBoletaUsuario['NOMBRE_COMPLETO'] ?? '')).toUpperCase(),
                                      style: const TextStyle(
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
                                color: const Color.fromARGB(255, 220, 228, 235),
                                border: Border.all(
                                  color: Colors.black
                                )
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el RTN
                                      ((_datosBoletaUsuario['FECHA_INGRESO'] ?? '')).toUpperCase(),
                                      style: const TextStyle(
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
                                color: const Color.fromARGB(255, 220, 228, 235),
                                border: Border.all(
                                  color: Colors.black
                                )
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      ((_datosBoletaUsuario['PUESTO'] ?? '')).toUpperCase(),
                                      style: const TextStyle(
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
                                color: const Color.fromARGB(255, 220, 228, 235),
                                border: Border.all(
                                  color: Colors.black
                                )
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el RTN
                                      ((_datosBoletaUsuario['DEPARTAMENTO'] ?? '')).toUpperCase(),
                                      style: const TextStyle(
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  estiloTextos((_datosBoletaUsuario['FECHA_QUINCENA'] ?? '')).toUpperCase(),
                                  style: const TextStyle(
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  ((_datosBoletaUsuario['DNI'] ?? '')).toUpperCase(),
                                  style: const TextStyle(
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
                                color: const Color.fromARGB(255, 220, 228, 235),
                                border: Border.all(
                                  color: Colors.black
                                )
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['SUELDO_MENSUAL'] ?? 0),
                                      style: const TextStyle(
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
                                color: const Color.fromARGB(255, 220, 228, 235),
                                border: Border.all(
                                  color: Colors.black
                                )
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el RTN
                                      formatter.format(_datosBoletaUsuario['SUELDO_QUINCENAL'] ?? 0),
                                      style: const TextStyle(
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
                                      'Días Trabajados',
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
                                color: const Color.fromARGB(255, 220, 228, 235),
                                border: Border.all(
                                  color: Colors.black
                                )
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el RTN
                                      '${_datosBoletaUsuario['DIAS_TRABAJADOS']  ?? 'ND'} días',
                                      style: const TextStyle(
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
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Sueldo Devengado:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Otros Ingresos:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Bonificación:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
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
                             /*  color: const Color.fromARGB(255, 6, 82, 144), */
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['SUELDO_DEVENGADO'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['OTROS_INGRESOS'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['BONIFICACION'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "",
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
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "IHSS:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "ISR:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Incapacidad:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Préstamo a Empleado:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Viáticos No Liquidados:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Liquidación Viátic Vencida:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Repostería:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Aparato Telefónico:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Banco Ficensa Préstamos:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Seguro Medico Dependiente:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Impuesto Vecinal:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Go Crédio Ahorro:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Mi Óptica:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Otras Deducciones:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Carnet:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Plan Telefónico:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Credi/Lee:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Farmacias:",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      "Banco Atlántida Préstamos:",
                                      style: TextStyle(
                                        fontSize: 13
                                      ),
                                      textAlign: TextAlign.left,
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
                             /*  color: const Color.fromARGB(255, 6, 82, 144), */
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['IHSS'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['ISR'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['INCAPACIDAD'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['PRESTAMOS_EMPLEADOS'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['VIATICOS_NO_LIQUIDADOS'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['LIQUIDACION_VIA_VENCIDA'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['REPOSTERIA'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['APARATO_TELEFONICO'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['BANCO_FICENSA_PRESTAMO'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['SEGURO_MEDICO_DEP'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['IMPUESTO_VECINAL'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['GO_CREDITO_AHORRO'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['MI_OPTICA'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['OTRAS_DEDUCCIONES'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['CARNET'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['PLAN_TELEFONICO'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['CREDI_LEE'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['FARMACIAS'] ?? 0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 220, 228, 235),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      // Dato donde irá el nombre
                                      formatter.format(_datosBoletaUsuario['BANCO_ATLANTIDA_PRESTAMO'] ?? 0),
                                      textAlign: TextAlign.center,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Total Ingresos:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
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
                              height: 40,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 168, 215, 255),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      formatter.format(_datosBoletaUsuario['TOTAL_INGRESOS'] ?? 0),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
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
                              height: 40,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Total Deducciones:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
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
                              height: 40,
                              decoration: const BoxDecoration(
                                color:   Color.fromARGB(255, 168, 215, 255),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      formatter.format(_datosBoletaUsuario['TOTAL_DEDUCCIONES'] ?? 0),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
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
                    ]
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
                              height: 40,
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Valor Neto Recibido:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
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
                              height: 40,
                              decoration: const BoxDecoration(
                                color:    Color.fromARGB(255, 6, 82, 144),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      formatter.format(_datosBoletaUsuario['VALOR_NETO'] ?? 0),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
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
                      // Valor del valor neto recibido
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

estiloTextos(String texto){
  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  } 

  String capitalizeFullText(String fulltexto) {
    List<String> textParts = fulltexto.split(' ');
    List<String> capitalizedParts = textParts.map((part) => capitalize(part)).toList();
    return capitalizedParts.join(' ');
  }

  String capitalizedTexto = capitalizeFullText(texto);
  return capitalizedTexto;
}
