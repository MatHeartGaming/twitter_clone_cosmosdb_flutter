import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/presentation/screens/screens.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  //final goRouterNotifier = ref.watch(goRouterNotifierProvider);
  //final authUserState = ref.watch(authStatusProvider);
  return GoRouter(
    initialLocation: basePath,
    routes: [
      GoRoute(
        name: LoadingScreen.name,
        path: loadingPath,
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        name: HomeScreen.name,
        path: '$homePath/:page',
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? '0';
          return HomeScreen(
            pageIndex: int.parse(pageIndex),
            homeView: HomeView(),
            searchView: SearchView(),
            communityView: CommunityView(),
            notificationView: Text("notificationView"),
            messagesView: Text('Messages'),
          );
        },
      ),
      GoRoute(path: '/', redirect: (_, __) => basePath),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;

      //final isConnected = ref.watch(connectivityProvider);
      //final signedInUser = ref.watch(signedInUserProvider);

      if (isGoingTo == basePath) {
        return '$homePath/0';
      }

      return isGoingTo;
    },
  );
});

enum MaintenanceErrors {
  noConnection,
  maintenance,
  iOSBuildNumberIsHigher,
  androidBuildNumberIsHigher,
}
