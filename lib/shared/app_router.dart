import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

typedef Widget AppHandlerFunc(dynamic);

class AppRouteHandler {
  final AppHandlerFunc handlerFunc;

  AppRouteHandler({required this.handlerFunc});
}

class AppRoute {
  final String path;
  final AppRouteHandler handler;

  AppRoute(this.path, this.handler);
}

class AppRouter {
  static final appRouter = AppRouter();

  final List<AppRoute> routes = [];

  void define({
    required String routePath,
    required AppRouteHandler handler,
  }) {
    routes.add(AppRoute(routePath, handler));
  }

  Route<dynamic> matchRoute(String path, {RouteSettings? routeSettings}) {
    final routeMatched = routes.firstWhereOrNull(
      (route) => route.path == path,
    );

    if (routeMatched != null) {
      return MaterialPageRoute(
        settings: RouteSettings(
          name: path,
          arguments: routeSettings!.arguments,
        ),
        builder: (context) {
          return routeMatched.handler.handlerFunc(routeSettings.arguments);
        }
      );
    }

    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body:  Center(
          child: Text('path no implement'),
        ),
      ),
    );
  }
}

