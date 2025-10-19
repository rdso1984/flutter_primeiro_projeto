import 'package:flutter/material.dart';

class NavigatorObserverCustom extends NavigatorObserver {
  
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('didPush: ${route.settings.name}, from: ${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('didPop: ${route.settings.name}, to: ${previousRoute?.settings.name}');
  }
}