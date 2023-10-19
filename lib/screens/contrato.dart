import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visor de PDF'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              ();
            },
          ),
        ],
      ),
    );
  }
}
