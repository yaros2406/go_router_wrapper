import 'package:flutter/cupertino.dart';
import 'navigation_state_handler.dart';
import 'package:event_bus/event_bus.dart';

class RoutePopEvent {
  final dynamic value;
  RoutePopEvent(this.value);
}

class RouteAwareStateHandler extends RouteObserver<PageRoute<dynamic>> {
  final NavigationStateHandler _stateHandler;

  RouteAwareStateHandler(this._stateHandler);
  final EventBus eventBus = EventBus();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _stateHandler.saveCurrentRoute(route.settings.name ?? '');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute) {
      _stateHandler.saveCurrentRoute(route.settings.name ?? '');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _stateHandler.saveCurrentRoute(newRoute.settings.name ?? '');
    }
  }

  void popWithValue(BuildContext context, dynamic value) {
    eventBus.fire(RoutePopEvent(value));
    Navigator.of(context).pop();
  }
}