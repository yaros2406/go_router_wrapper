import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_test_app/keeper.dart';
import 'package:navigation_test_app/go_router_wrapper.dart';
import 'package:navigation_test_app/navigation_state_handler.dart';
import 'package:navigation_test_app/route_aware_state_handler.dart';
import 'screens.dart';

class AuthKeeper implements Keeper {
  @override
  final OnEnterCallback? onEnter;

  AuthKeeper() : onEnter = ((context, routeMatch, currentState, nextState, router) {
    // Логика проверки авторизации
    final isAuthenticated = false;//параметр-заглушка для примера, имитирует логику проверки авторизации, например, через провайдер состояния
    if (!isAuthenticated) {
      // Если пользователь не авторизован, остановить переход
      return Permit.reject;
    }
    return Permit.allow;
  });
}

void main() {
  final NavigationStateHandler stateHandler = NavigationStateHandler();
  final RouteAwareStateHandler routeObserver = RouteAwareStateHandler(stateHandler);
  final keepers = [
    AuthKeeper(),
  ];

  final routes = [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        // Получение параметра авторизации из состояния или провайдера
        final isAuthenticated = false;//имитация логики получения состояния авторизации
        return ProfileScreen(isAuthenticated: isAuthenticated);
      },
    ),
  ];

  final goRouterWrapper = GoRouterWrapper(
    routes: routes,
    keepers: keepers,
    transitionRules: [],
    saveStateObservers: [routeObserver],
  );

  runApp(MyApp(router: goRouterWrapper.router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}