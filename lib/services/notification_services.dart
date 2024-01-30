//SHA1: A5:6A:26:A3:8D:05:A0:BD:4B:14:E4:F6:B0:F6:83:E3:47:D0:56:82

import "dart:async";

import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
//import "package:flutter_local_notifications/flutter_local_notifications.dart";


class PushNotificationService{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler( RemoteMessage message) async {
    //print( 'background Handler ${message.messageId}');

    _messageStream.add( message.notification?.title ?? 'No title');
  }

  static Future _onMessageHandler( RemoteMessage message) async {
    //print( 'onMessage Handler ${message.messageId}');

    _messageStream.add( message.notification?.title ?? 'No title');
  }

    static Future _onMessageOpenApp( RemoteMessage message) async {
    //print( 'onMessageOpenApp Handler ${message.messageId}');

    _messageStream.add( message.notification?.title ?? 'No title');
  }

  static Future initializeApp() async {
  try {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  //Handlers
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  FirebaseMessaging.onMessage.listen(_onMessageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

  //Local Notifications

}

static closeStreams(){
  _messageStream.close();
}
  
}

