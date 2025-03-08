
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
          path: basePath,
          builder: (context, state) {
            return const HomeScreen();
          },
        ),
      GoRoute(path: '/', redirect: (_, __) => basePath),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;

      //final isConnected = ref.watch(connectivityProvider);
      //final signedInUser = ref.watch(signedInUserProvider);

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
