import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class VacationRequestScreen extends StatefulWidget {
  const VacationRequestScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VacationRequestScreenState createState() => _VacationRequestScreenState();
}

class _VacationRequestScreenState extends State<VacationRequestScreen> {
  late DateTime _startDate;
  late DateTime _endDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _endDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _endDate)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        _endDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 7));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'VACACIONES',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Seleccione las fechas que quiere solicitar:",
              style: GoogleFonts.croissantOne(
                  fontSize: 25, color: const Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => _selectStartDate(context),
              child: Text(
                "Seleccione la fecha de inicio",
                style: GoogleFonts.croissantOne(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 30, 0, 255)),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Fecha de Inicio: ${DateFormat('dd-MM-yyyy').format(_startDate)}",
              style: GoogleFonts.croissantOne(
                  fontSize: 15, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => _selectEndDate(context),
              child: Text(
                "Seleccione la fecha de fin",
                style: GoogleFonts.croissantOne(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 30, 0, 255)),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'Fecha de Fin: ${DateFormat('dd-MM-yyyy').format(_endDate)}',
              style: GoogleFonts.croissantOne(
                  fontSize: 15, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(height: 20),
            Text(
              "Días disponibles: 20",
              style: GoogleFonts.croissantOne(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 16, 196, 0)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              "Razón de la Solicitud:",
              style: GoogleFonts.croissantOne(
                  fontSize: 25, color: const Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Ingrese la razón de su solicitud de vacaciones...',
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
            Container(
              height: MediaQuery.of(context).size.height / 6,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/vacaciones.png"),
                      fit: BoxFit.cover)),
            )
          ],
        ),
      ),
    );
  }
}
