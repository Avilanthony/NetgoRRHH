import "dart:io";

import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:open_file/open_file.dart";
import "package:path_provider/path_provider.dart";

class NotificationService{
  final FlutterLocalNotificationsPlugin notificationsPluggin = FlutterLocalNotificationsPlugin();

  Future <void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings("logo");

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );

    await notificationsPluggin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:(
        NotificationResponse notificationResponse 
      ) async {
        await handleClickNotificationResponse(notificationResponse);
        late String? pdfFilePath = notificationResponse.payload;
        if (pdfFilePath != null) {
        // Abrir el archivo PDF usando la ruta guardada
        // Aquí puedes implementar la lógica para abrir el PDF
        }
      }
    );
  }

  Future<void> handleClickNotificationResponse(NotificationResponse notificationResponse) async {
    // Aquí puedes manejar lógica adicional al hacer clic en la notificación
    // Por ejemplo, abrir el directorio de descargas
    /* if (notificationResponse.didOpenApp || notificationResponse.payload == null) {
      // La aplicación está abierta o la notificación no tiene carga útil
      return;
    } */

    // Abrir el directorio de descargas
    await openFile();
  }

  Future<void> openFile() async {

    var directory = await getDownloadsDirectory();
      if (directory != null) {
        String pdfPath = "${directory.path}/Boletica.pdf";
        if (await File(pdfPath).exists()) {
          // Abrir el archivo PDF
          await OpenFile.open(pdfPath);
        } else {
          print("El archivo PDF no existe en la ruta: $pdfPath");
        }
      } else {
        print("No se pudo obtener el directorio de descargas.");
      }
  }


  Future<void> openDownloadsDirectory() async {
    try {
      var directory = await getDownloadsDirectory();
      if (directory != null) {
        await OpenFile.open(directory.path);
      } else {
        print("No se pudo obtener el directorio de descargas.");
      }
    } catch (e) {
      print("Error al abrir el directorio de descargas: $e");
    }
  }

  notificationDetails(){

    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId", 
        "channelName",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showProgress: false,
        onlyAlertOnce: true,
      ),
      iOS: DarwinNotificationDetails()
    );

  }

  Future showNotification({

    int id = 0, String? title, String? body, String? pdfFilePath

  }) async {

    return notificationsPluggin.show(id, title, body, await notificationDetails(), payload: pdfFilePath);

  }
}

