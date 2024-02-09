import 'package:go_router/go_router.dart';
import 'package:recursos_humanos_netgo/main.dart';
import 'package:recursos_humanos_netgo/model/notificaciones/details_notification.dart';

final appRouter = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
      ),

    GoRoute(
      path: '/push-details/:messageId',
      builder: (context, state) => DetailsNotificationScreen(pushMessageId: state.pathParameters['messageId'] ?? '',),
      ),

  ]
);