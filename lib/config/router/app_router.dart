import 'package:go_router/go_router.dart';
import 'package:recursos_humanos_netgo/presentation/screens/details_screen.dart';
import 'package:recursos_humanos_netgo/presentation/screens/home_screen.dart';


final appRouter = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreenNotifications(),
    ),

    GoRoute(
      path: '/push-details/:messageId',
      builder: (context, state) => DetailsScreen( pushMessageId: state.pathParameters['messageId'] ?? '', ),
    ),

  ]
  
);