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

class BoletaPdfViewerScreen extends StatefulWidget {
  final int usuarioId;
  final token;
  const BoletaPdfViewerScreen(
      {Key? key, required this.usuarioId, required this.token})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<BoletaPdfViewerScreen> {
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
              onPressed: () async {
                final androidInfo = await DeviceInfoPlugin().androidInfo;
                late final Map<Permission, PermissionStatus>
                    statusses /* = await [Permission.storage].request() */;
                if (Platform.isAndroid) {
                  if (androidInfo.version.sdkInt <= 32) {
                    statusses = await [Permission.storage].request();
                  } else {
                    statusses = await [Permission.notification].request();
                  }
                } else {
                  statusses = await [Permission.storage].request();
                }

                print("Status de permisos: ${statusses[Permission.storage]}");
                var allAcepted = true;
                statusses.forEach((permission, status) {
                  if (status != PermissionStatus.granted) {
                    allAcepted = false;
                  }
                });
                if (allAcepted) {
                  /* bool dirDownloadExists = true;
                  dynamic directory;
                  String path; */

                  /* if (Platform.isIOS) {
                    directory = await getDownloadsDirectory();
                  } else {

                    dirDownloadExists = await Directory(directory).exists();
                    if(dirDownloadExists){
                      path = "/storage/emulated/0/Download";
                      directory = File(path);
                    }else{
                      path = "/storage/emulated/0/Download";
                      directory = File(path);
                    }
                  } */
                  var directory = await getDownloadsDirectory();
                  if (directory != null) {
                    String appFolder;
                    /* if (Platform.isIOS) {
                      appFolder = "${directory.path}";
                    } else {
                      appFolder = directory;
                    } */
                    appFolder = directory.path;
                    await Directory(appFolder).create(recursive: true);
                    String guardaComo = "Boletica.pdf";
                    String savePath = "$appFolder/$guardaComo";
                    print(savePath);

                    try {
                      await Dio().download(pdfurl, savePath,
                          onReceiveProgress: (received, total) {
                        if (total != -1) {
                          print(
                              "${(received / total * 100).toStringAsFixed(0)}%");
                        }
                      });
                      print("Archivo guardado en la carpeta RRHH_Netgo");
                      NotificationService().showNotification(
                        title: "Descargar de Archivo",
                        body:
                            "El archivo ha sido guardado en la carpeta RRHH_Netgo",
                        pdfFilePath: savePath,
                      );
                    } on DioException catch (e) {
                      print(e.message);
                    }
                  } else {
                    print("No se pudo obtener el directorio de descargas");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Permiso Denegado"),
                    ));
                  }
                }
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 236, 237, 255),
        body: Container(
          color: const Color.fromARGB(255, 236, 237, 255), // Establece el color de fondo del segundo Container
          child: Container(
            padding: const EdgeInsets.all(20),
            child: /* SfPdfViewer.network(usuarioBoleta), */
                usuarioBoleta == '' || usuarioBoleta.isEmpty
                    ? Text(
                        "No hay una boleta de pago visible.",
                        style: GoogleFonts.croissantOne(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        textAlign: TextAlign.center,
                      )
                    : SfPdfViewer.network(
                        /* usuarioBoleta */
                        usuarioBoleta),
          ),
        ),
      ),
    );
  }
}
