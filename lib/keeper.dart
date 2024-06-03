import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

//onEnter является заменой для оригинального redirect.
//onEnter возвращает значение Permit, которое сообщает роутеру, следует ли переходить к следующему keeper.
//Permit.allow означает, что keeper не влияет на этот маршрут, поэтому роутер перейдет к следующему keeper.
//Permit.reject означает, что keeper запретил маршрут, и роутер остановит движение.
//Успешный переход до конечной точки означает, что все keepers на маршрутах возвращают Permit.allow.
//Порядок выполнения - сверху вниз. Если на одном маршруте несколько keepers, то выполнение идет с первого до последнего.

// Фабрика Keeper
abstract class Keeper {
  factory Keeper(OnEnterCallback onEnter) => _GoRouterKeeper(onEnter: onEnter);
  OnEnterCallback? get onEnter;
}

class _GoRouterKeeper implements Keeper {
  _GoRouterKeeper({this.onEnter});
  @override
  final OnEnterCallback? onEnter;
}

enum Permit {
  allow,
  reject,
}

typedef OnEnterCallback = Permit Function(
    BuildContext context, RouteMatch routeMatch, GoRouterState currentState, GoRouterState nextState, GoRouter router);