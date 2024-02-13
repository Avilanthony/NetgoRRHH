// ignore_for_file: unused_field, library_private_types_in_public_api, prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/config.dart';

class ConstanciaPdfViewerScreen extends StatefulWidget {
  final token;
  const ConstanciaPdfViewerScreen({required this.token, Key? key})
      : super(key: key);

  @override
  _ConstanciaSolicitudScreenState createState() =>
      _ConstanciaSolicitudScreenState();
}

class _ConstanciaSolicitudScreenState extends State<ConstanciaPdfViewerScreen> {
  String _selectedDeliveryOption = 'Correo Electrónico';
  String _selectedLocationOption = 'Local A';
  String _requesterName = '';
  String _description = '';

  TextEditingController messageController = TextEditingController();

  late String usuario = '';
  String usuarioPrimerNombre = '';
  String usuarioSegundoNombre = '';
  String usuarioPrimerApellido = '';
  String usuarioSegundoApellido = '';
  String usuarioDepartamento = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
    obtenerInformacionUsuario();
  }

  Future<void> obtenerInformacionUsuario() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$ticket/ticket_usuario/$usuario'), // Reemplaza con la URL correcta de tu backend
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        setState(() {
          // Actualiza el estado con la información del usuario
          usuarioPrimerNombre = myUsuario['PRIMER_NOMBRE'];
          usuarioSegundoNombre = myUsuario['SEGUNDO_NOMBRE'];
          usuarioPrimerApellido = myUsuario['APELLIDO_PATERNO'];
          usuarioSegundoApellido = myUsuario['APELLIDO_MATERNO'];
          usuarioDepartamento = myUsuario['DEPARTAMENTO'];
          //VER QUE TRAE LOS DATOS DESDE LA CONSOLA
          print(usuarioPrimerNombre);
          print(usuarioSegundoNombre);
          print(usuarioPrimerApellido);
          print(usuarioSegundoApellido);
          print(usuarioDepartamento);
          // Otros campos del usuario...
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

  Future<void> enviarNotificacion() async {
    try {
      final response = await http.post(
        Uri.parse('$ticket/enviar_ticket'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id_usuario_origen': usuario, // Reemplaza con el valor correcto
          'asunto':
              'Solicitud de Constancia', // Reemplaza con el valor correcto
          'detalle':
              'Lo solicito mediante $_selectedDeliveryOption, ${messageController.text}',
          'departamento_usuario': usuarioDepartamento,
        }),
      );

      if (response.statusCode == 200) {
        // Notificación exitosa, puedes manejar la respuesta según sea necesario
        print('Notificación exitosa');
        messageController.clear(); // Limpiar el TextField
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Solicitud enviada con éxito'),
          ),
        );
      } else {
        // Maneja el error según sea necesario
        print('Error en la notificación: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja errores de red u otros errores aquí
      print('Error: $error');
    }
  }

  final List<String> deliveryOptions = [
    'Correo Electrónico',
    'Entrega en Persona',
    'WhatsApp'
  ];

  bool showLocationDropdown = false;

  void mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 81, 124, 193),
            title: Text.rich(
              TextSpan(
                  text: 'Solicitud de constancia',
                  style: GoogleFonts.josefinSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 236, 237, 255),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nombre del Solicitante:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '$usuarioPrimerNombre $usuarioSegundoNombre $usuarioPrimerApellido $usuarioSegundoApellido',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Departamento del Solicitante:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '$usuarioDepartamento',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Seleccione la Opción de Entrega:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: _selectedDeliveryOption,
                    items: deliveryOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDeliveryOption = newValue!;
                        showLocationDropdown = newValue == 'Entrega en Persona';
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Formato de la Constancia:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  Text(
                    '${_selectedDeliveryOption == 'Entrega en Persona' ? 'Documento Físico' : 'PDF'}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 40),
                  const SizedBox(height: 20),
                  const Text(
                    'Especificación de la Solicitud:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: messageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          'Ingrese alguna especificación sobre su constancia...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        enviarNotificacion();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 81, 124, 193),
                        ),
                      ),
                      child: const Text(
                        'Enviar Solicitud',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
