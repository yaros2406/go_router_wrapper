import 'package:shared_preferences/shared_preferences.dart';

class NavigationStateHandler {
  static const String _lastRouteKey = 'last_route';

  //Сохранить текущее состояние маршрута
  Future<void> saveCurrentRoute(String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastRouteKey, route);
  }

  //Получить сохраненное состояние маршрута
  Future<String?> getSavedRoute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastRouteKey);
  }
}