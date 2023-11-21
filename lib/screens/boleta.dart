import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
/* import 'package:downloads_path_provider_28/downloads_path_provider_28.dart'; */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recursos_humanos_netgo/services/notificacion_pdf_service.dart';
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
  void initState() {
    super.initState();
    NotificationService().initNotification();
    
  }
  String pdfurl = 'https://www.unah.edu.hn/assets/Admisiones/plan-de-estudios/Licenciatura-en-Mercadotecnia-2022.pdf';
  
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
              onPressed: () async{
                final androidInfo = await DeviceInfoPlugin().androidInfo;
                late final Map<Permission, PermissionStatus> statusses /* = await [Permission.storage].request() */;
                if (Platform.isAndroid) {
                  if (androidInfo.version.sdkInt <= 32){
                    statusses = await[
                      Permission.storage
                    ].request();
                  } else {
                    statusses = await [
                      Permission.notification
                    ].request();
                  }
                } else {
                  statusses = await [
                    Permission.storage
                  ].request();
                }
                
                print("Status de permisos: ${statusses[Permission.storage]}");
                var allAcepted = true;
                statusses.forEach((permission, status) {
                  if (status != PermissionStatus.granted) {
                    allAcepted = false;
                  }
                 });
                if(allAcepted){
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
                  if(directory!=null){
                    String appFolder;
                    /* if (Platform.isIOS) {
                      appFolder = "${directory.path}";
                    } else {
                      appFolder = directory;
                    } */
                    appFolder = directory.path;
                    await Directory(appFolder).create(recursive: true);
                    String guardaComo = "boletica.pdf";
                    String savePath = "$appFolder/$guardaComo";
                    print(savePath);

                    try {
                      await Dio().download(
                        pdfurl, 
                        savePath,
                        onReceiveProgress: (received, total){
                          if (total != -1) {

                            print("${(received/total*100).toStringAsFixed(0)}%");

                            
                          }
                        }
                      );
                      print("Archivo guardado en la carpeta RRHH_Netgo");
                      NotificationService().showNotification(
                        title: "Descargar de Archivo",
                        body: "El archivo ha sido guardado en la carpeta RRHH_Netgo",
                        pdfFilePath: savePath,
                      );
                    } on DioException catch (e) {

                      print(e.message);
                      
                    }
                  }
                  else{

                    print("No se pudo obtener el directorio de descargas");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Permiso Denegado"),
                      )
                    );
                    

                  }
                }
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
