import 'package:flutter/material.dart';

class NavigationTypeObserver extends NavigatorObserver {
  Function(Route, Route?, String) onNavigation;

  NavigationTypeObserver({required this.onNavigation});

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    onNavigation(route, previousRoute, 'pop');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    onNavigation(route, previousRoute, 'push');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    onNavigation(newRoute!, oldRoute, 'replace');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    onNavigation(route, previousRoute, 'remove');
  }
}

String determineNavigationType(String type) {
  switch (type) {
    case 'pop':
      return 'pop';
    case 'push':
      return 'push';
    case 'replace':
      return 'replace';
    case 'remove':
      return 'remove';
    default:
      return 'unknown';
  }
}