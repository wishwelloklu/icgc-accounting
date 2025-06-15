import 'package:flutter/widgets.dart';

class AppRouteObserver implements RouteObserver {
  Route? _currentRoute;
  @override
  void didChangeTop(Route topRoute, Route? previousTopRoute) {
    // TODO: implement didChangeTop
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    _currentRoute = previousRoute;
    debugPrint('route didPop ${route.settings.name}');
    debugPrint('route didPop ${previousRoute?.settings.name}');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
    _currentRoute = route;
    debugPrint('route didPush ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // TODO: implement didRemove
    // _currentRoute = route;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    // TODO: implement didReplace
    // _currentRoute = newRoute;
    // debugPrint('route didReplace $newRoute');
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    // TODO: implement didStartUserGesture
    debugPrint('route didStartUserGesture ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {
    // TODO: implement didStopUserGesture
  }

  @override
  bool debugObservingRoute(Route route) {
    // TODO: implement debugObservingRoute
    debugPrint('route debugObservingRoute ${route.settings.name}');
    throw UnimplementedError();
  }

  @override
  void subscribe(RouteAware routeAware, Route route) {
    debugPrint('route subscribe ${route.settings.name}');
    // TODO: implement subscribe
  }

  @override
  void unsubscribe(RouteAware routeAware) {
    // TODO: implement unsubscribe
  }

  @override
  // TODO: implement navigator
  NavigatorState? get navigator => _currentRoute?.navigator;

  String? get currentRouteName => _currentRoute?.settings.name;
}
