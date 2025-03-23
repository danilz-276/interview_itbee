import 'package:flutter/material.dart';

import 'logger.dart';

List<String> routeStack = ["/"];

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _trackScreen('open', route: route);
    _trackScreen('close', route: previousRoute);

    if (route.settings.name != null) {
      logger.i("didPushabc: ${route.settings.name}");
      routeStack.add(route.settings.name!);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _trackScreen('close', route: route);
    _trackScreen('open', route: previousRoute);
    if (route.settings.name != null) {
      logger.i("didPop: ${route.settings.name}");
      routeStack.removeLast();
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      logger.i("didRemove: ${route.settings.name}");
      routeStack.removeLast();
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _trackScreen('open', route: newRoute);
    _trackScreen('close', route: oldRoute);
    if (newRoute?.settings.name != null) {
      logger.i("didRemove: ${newRoute?.settings.name}");
      routeStack.removeLast();
      routeStack.add(newRoute!.settings.name!);
    }
  }

  void _trackScreen(String type, {String? routeName, Route? route}) {
    String? routeTrack = routeName ?? route?.settings.name;
    if (routeTrack != null) {
      // FirebaseTrack.trackScreen(routeTrack, type);
    }
  }
}
