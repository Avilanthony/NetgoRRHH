import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// ignore: depend_on_referenced_packages

class BoletaPdfViewerScreen extends StatefulWidget {
  const BoletaPdfViewerScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<BoletaPdfViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 81, 124, 193),
          title: Text.rich(
            TextSpan(
                text: 'BOLETA DE PAGO',
                style: GoogleFonts.josefinSans(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.download,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                // Agrega la lógica para mostrar las notificaciones aquí
              },
            ),
          ],
        ),
        body: Container(
          color:
              const Color.fromRGBO(216,212,212,1), // Establece el color de fondo del segundo Container
          child: Container(
            padding: const EdgeInsets.all(20),
            child: SfPdfViewer.asset('assets/pdf/boleta.pdf'),
          ),
        ),
      ),
    );
  }
}
