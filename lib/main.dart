// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/blocs/notifications/notifications_bloc.dart';
import 'package:recursos_humanos_netgo/config/routes/app_router.dart';
import 'package:recursos_humanos_netgo/config/routes/local_notification/local_notifications.dart';
import 'package:recursos_humanos_netgo/login.dart';
import 'package:recursos_humanos_netgo/model/dashboard/dashboard.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/notification_view.dart';
//import 'package:recursos_humanos_netgo/services/notification_services.dart';
import 'package:recursos_humanos_netgo/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runAppWithObserver();
}

void runAppWithObserver() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  //await Firebase.initializeApp();

  // Inicializar FCM
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationsBloc.initializeFCM();
  await LocalNotifications.initializeLocalNotifications();

  // Crear el bloc después de inicializar Firebase y FCM
  final myObserver = MyNavigatorObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NotificationsBloc(
          requestLocalNotificationsPermission: LocalNotifications.requestPermissionLocalNotifications,
          showLocalNotification: LocalNotifications.showLocalNotification
        ))
      ],
      child: MaterialApp(
        navigatorObservers: [myObserver],
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<Widget>(
          future: determineHomeScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return HandleNotificationInteractions(child: snapshot.data!);
            } else {
              return Container(); // Puedes cambiar esto a un indicador de carga si lo deseas
            }
          },
        ),
      ),
    ),
  );
}


Future<Widget> determineHomeScreen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token != null && !JwtDecoder.isExpired(token)) {
    return Dashboard(token: token);
  } else {
    return MyHomePage(token: token);
  }
}

class MyHomePage extends StatefulWidget {
  final String? token;
  /* final String title; */
  const MyHomePage({
    this.token,
    /* required this.title, */
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyNavigatorObserver extends NavigatorObserver {
  static BuildContext? navigatorContext;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    navigatorContext = route.navigator!.context;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    navigatorContext = previousRoute?.navigator!.context;
  }
}

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.payload != null) {
      final payloadMap = Map<String, dynamic>.from(receivedAction.payload!);
      final screen = payloadMap['screen'];

      if (screen == 'tickets' && MyNavigatorObserver.navigatorContext != null) {
        // Navegar a la pantalla de Notificaciones
        Navigator.push(
          MyNavigatorObserver.navigatorContext!,
          MaterialPageRoute(builder: (context) => NotificationView()),
        );
      }
      // Agrega más casos según las pantallas que tengas
    }
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final String? token;

  _MyHomePageState({
    @required this.token,
  });

  @override
  /* void initState() {
    PushNotificationService.messageStream.listen((message) {
      print('MyApp: $message');
     });

     _requestNotificationPermissions();

    super.initState();
  } */

  /* void _requestNotificationPermissions() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 237, 255),
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //AQUI
                Column(
                  children: <Widget>[
                    Text(
                      "Bienvenido",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Para acceder a la aplicación primero debes ingresar tus datos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[780],
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),

                //AQUI

                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Header.png"))),
                ),

                //AQUÍ

                Column(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Ingresar",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),

                    //SIGUIENTE BOTÓN

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 1.5, left: 1.5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: /* triggerNotification */ () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        color: Color.fromARGB(255, 139, 194, 68),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Registrarse",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}

class HandleNotificationInteractions extends StatefulWidget {
  final Widget child;
  const HandleNotificationInteractions({super.key, required this.child});

  @override
  State<HandleNotificationInteractions> createState() => _HandleNotificationInteractionsState();
}

class _HandleNotificationInteractionsState extends State<HandleNotificationInteractions>{

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  
  void _handleMessage(RemoteMessage message) {

    context.read<NotificationsBloc>().handleRemoteMessage(message);

    final messageId = message.messageId?.replaceAll(':', '').replaceAll('%', '');
    appRouter.push('/push-details/$message');

  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
