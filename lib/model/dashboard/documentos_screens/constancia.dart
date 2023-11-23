// ignore_for_file: unused_field, library_private_types_in_public_api, prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstanciaPdfViewerScreen extends StatefulWidget {
  const ConstanciaPdfViewerScreen({Key? key}) : super(key: key);

  @override
  _ConstanciaSolicitudScreenState createState() =>
      _ConstanciaSolicitudScreenState();
}

class _ConstanciaSolicitudScreenState extends State<ConstanciaPdfViewerScreen> {
  String _selectedDeliveryOption = 'Correo Electrónico';
  String _selectedLocationOption = 'Local A';
  String _requesterName = '';
  String _description = '';

  final List<String> deliveryOptions = [
    'Correo Electrónico',
    'Entrega en Persona',
    'WhatsApp'
  ];
  final List<String> locationOptions = ['Local A', 'Local B', 'Local C'];

  bool showLocationDropdown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'Solicitud de constancia',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre del Solicitante:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              'Anthony Joshua Avila Laguna',
              style: TextStyle( fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Departamento del Solicitante:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              'IT',
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
            if (showLocationDropdown)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seleccione el Local de Entrega:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: _selectedLocationOption,
                    items: locationOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocationOption = newValue!;
                      });
                    },
                  ),
                ],
              ),
            const SizedBox(height: 20),
            const Text(
                    'Especificación de la Solicitud:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
            const SizedBox(height: 10),
            const TextField(
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
                  // Aquí puedes implementar la lógica para enviar la solicitud
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 81, 124, 193),
                  ), // Cambia el color aquí
                ),
                child: const Text('Enviar Solicitud'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
