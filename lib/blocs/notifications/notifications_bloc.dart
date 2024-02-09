import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:recursos_humanos_netgo/config/routes/local_notification/local_notifications.dart';
import 'package:recursos_humanos_netgo/domain/entities/push_message.dart';
//import 'package:recursos_humanos_netgo/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int pushNumberId = 0;

  final Future<void> Function()? requestLocalNotificationsPermission;
  final void Function(
      {required int id,
      String? title,
      String? body,
      String? data})? showLocalNotification;

  NotificationsBloc(
      {this.requestLocalNotificationsPermission, this.showLocalNotification})
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);

    //Verificar el estado de las notificaciones
    _initialStatusCheck();
    //Listener para notificaciones en foreground
    _onForegroundMessage();
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
        //options: DefaultFirebaseOptions.currentPlatform,
        );
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state
        .copyWith(notifications: [event.pushMessage, ...state.notifications]));
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  //Obtener el Token del dispositivo
  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print('Token nuevo metodo $token');
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);

    print(notification);
    if (showLocalNotification != null) {
      showLocalNotification!(
        id: ++pushNumberId,
        body: notification.body,
        data: notification.messageId,
        title: notification.title,
      );
    }

    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    //Solicitar permiso a las local notification
    if (requestLocalNotificationsPermission != null) {
      await requestLocalNotificationsPermission!();
    }
    //await LocalNotifications.requestPermissionLocalNotifications();

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String PushMessageId) {
    final exist = state.notifications
        .any((element) => element.messageId == PushMessageId);
    if (!exist) return null;

    return state.notifications
        .firstWhere((element) => element.messageId == PushMessageId);
  }
}
