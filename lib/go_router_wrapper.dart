library go_router_wrapper;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_test_app/route_aware_state_handler.dart';
import 'transitions_settings.dart';
import 'keeper.dart';
import 'navigation_type_observer.dart';

class GoRouterWrapper {
  late final GoRouter _router;
  final List<Keeper> _keepers;
  final List<TransitionRule> _transitionRules;
  String? _lastNavigationType;

  GoRouterWrapper({
    required List<GoRoute> routes,
    required List<Keeper> keepers,
    required List<TransitionRule> transitionRules,
    String? initialLocation,
    required List<RouteAwareStateHandler> saveStateObservers,
  })  : _keepers = keepers,
        _transitionRules = transitionRules {
    _router = GoRouter(
      routes: routes,
      initialLocation: initialLocation,
      redirect: (context, state) async {
        for (var keeper in _keepers) {
          if (keeper.onEnter != null) {
            final RouteMatch routeMatch = _router.routerDelegate.currentConfiguration.last;
            final permission = keeper.onEnter!(context, routeMatch, state, state, _router);
            if (permission == Permit.reject) {
              for (var rule in _transitionRules) {
                if (state.uri.toString().contains(rule.pathPattern)) {
                  handleTransition(context, rule);
                  break;
                }
              }
              return state.uri.toString();
            }
          }
        }
        return null;
      },
      observers: [NavigationTypeObserver(onNavigation: (route, previousRoute, type) {
        _lastNavigationType = determineNavigationType(type);
        //Определение типа навигации
        if (kDebugMode) {
          print('Navigation type: $_lastNavigationType');
        }
      })],
    );
  }
  String get lastNavigationType => _lastNavigationType ?? 'unknown';

  GoRouter get router => _router;

  //Добавить новый keeper динамично
  void addKeeper(Keeper keeper) {
    _keepers.add(keeper);
     _router.refresh();
  }

  //Метод для смены маршрута в простой навигационной схеме
  void updatePartialContent(BuildContext context, String location) {
    context.go(location);
  }
  //Пример использования
 // void someFunction(BuildContext context) {
    //логика определения нового пути
   // String newLocation = '/newPath';

    //обновление маршрута
    //goRouterWrapper.updatePartialContent(context, newLocation);
 // }
}