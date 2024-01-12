import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContextProvider {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void pushReplacementNamed(String routeName, {Object? extra}) {
    return navigatorKey.currentContext!
        .pushReplacementNamed(routeName, extra: extra);
  }

  Object? pushNamed(String routeName, {Object? extra}) {
    return navigatorKey.currentContext!.pushNamed(routeName, extra: extra);
  }

  void pop() {
    return navigatorKey.currentContext!.pop();
  }

  BuildContext get currentContext {
    return navigatorKey.currentState!.context;
  }
}
