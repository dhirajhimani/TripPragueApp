import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:trip_prague/app/constants/enum.dart';
import 'package:trip_prague/app/constants/route.dart';
import 'package:trip_prague/app/observers/go_route_observer.dart';
import 'package:trip_prague/app/routes/app_routes.dart';
import 'package:trip_prague/app/utils/injection.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';

@injectable
class AppRouter {
  AppRouter(@factoryParam this.tripPragueBloc);

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  final ValueKey<String> scaffoldKey = const ValueKey<String>('scaffold');
  final TripPragueBloc tripPragueBloc;

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteName.initial.path,
    routes:
        getIt<AppRoutes>(param1: shellNavigatorKey, param2: scaffoldKey).routes,
    redirect: _routeGuard,
    refreshListenable: GoRouterRefreshStream(tripPragueBloc.stream),
    observers:
        kDebugMode ? <NavigatorObserver>[getIt<GoRouteObserver>()] : null,
  );

  String? _routeGuard(_, GoRouterState state) {
    final TripPragueState tripPragueState = tripPragueBloc.state;
    final String loginPath = RouteName.login.path;
    final String initialPath = RouteName.initial.path;
    final String homePath = RouteName.home.path;
    final String day1 = RouteName.day1.path;

    // Check if app is still initializing
    if (tripPragueState.authStatus == AuthStatus.unknown) {
      return initialPath;
    }

    final bool authenticated =
        tripPragueState.authStatus == AuthStatus.authenticated;
    // Check if the app is in the login screen
    final bool isLoginScreen = state.subloc == loginPath;
    final bool isSplashScreen = state.subloc == initialPath;

    // Go to login screen if the user is not yet logged in
    if (!authenticated && (!isLoginScreen || !isSplashScreen)) {
      return loginPath;
    }
    // Go to home screen if the app is authenticated but tries to go to login screen or is still in the splash screen.
    else if (authenticated && (isLoginScreen || isSplashScreen)) {
      return day1;
    }

    return null;
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
