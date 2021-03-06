import 'package:bestfitnesstrackereu/pages/layout_template/layout_template.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:bestfitnesstrackereu/routing/router.dart';
import 'package:bestfitnesstrackereu/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'locator.dart';


void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Open Sans'
        ),
      ),
      builder: (context, child) => LayoutTemplate(
        child1: child,
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HomeRoute,
    );
  }
}
