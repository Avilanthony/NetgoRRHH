// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:recursos_humanos_netgo/login.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/notification_view.dart';
import 'package:recursos_humanos_netgo/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runAppWithObserver();
  AwesomeNotifications().initialize(
  null, // Reemplaza con la ruta correcta a tu icono de la aplicación
  [
     NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ],
  debug: true
  
);
  runApp(MaterialApp(
    
    debugShowCheckedModeBanner: false,
    home: MyHomePage(
      title: '',
      token: prefs.getString('token'),
    ),
  ));
}

void runAppWithObserver() async {
  final myObserver = MyNavigatorObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  runApp(MaterialApp(
    navigatorObservers: [myObserver],
    debugShowCheckedModeBanner: false,
    home: MyHomePage(
      title: '',
      token: prefs.getString('token'),
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  
  final token;
  final String title;
  const MyHomePage({
    
    @required this.token,
    required this.title,
    Key? key,

  }):super(key: key);

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
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
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

  
@override
  void initState() {

    _requestNotificationPermissions();

    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
/*         onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod */
    );

    super.initState();
  }
  void _requestNotificationPermissions() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }
  
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
