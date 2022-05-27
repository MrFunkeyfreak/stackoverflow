import 'package:bestfitnesstrackereu/extensions/string_extensions.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:flutter/material.dart';
import '../pages/about/about_view.dart';
import '../pages/episodes/episodes_view.dart';
import '../pages/home/home_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData; // Get the routing Data
  switch (routingData.route) {
    case HomeRoute:
      return _getPageRoute(HomeView(), settings);
    case EpisodesRoute:
      return _getPageRoute(EpisodesView(), settings);
    case AboutRoute:
      return _getPageRoute(AboutView(), settings);
    default:
      return _getPageRoute(HomeView(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(
    child: child,      //Widget child for displaying the widget
    routeName: settings.name    //routeName for named routing
  );
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
    settings: RouteSettings(name: routeName),     //setting routeName
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) => child,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}