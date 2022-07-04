import 'package:bestfitnesstrackereu/pages/layout_template/layout_template.dart';
import 'package:bestfitnesstrackereu/pages/login/authentication.dart';
import 'package:bestfitnesstrackereu/provider/auth.dart';
import 'package:bestfitnesstrackereu/provider/users_table.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:bestfitnesstrackereu/routing/router.dart';
import 'package:bestfitnesstrackereu/services/navigation_service.dart';
import 'package:bestfitnesstrackereu/widgets/loading_circle/loading_circle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'locator.dart';

// connection to the database -> connection need to be ensured
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCaos63TeR_y3YVXxD5x180IYz3ssQeWHE",
      appId: "1:414667114455:web:e0d8cdd30559bc41576d92",
      messagingSenderId: "414667114455",
      projectId: "thebasics-fb4e8",
    ),
  );

  // initialize the notifyListeners
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider.value(value: UsersTable.init()),
  ],
      child: MyApp()));
  setupLocator();  // initialize the locator
}

// setting language to german + setting the navigatorKey,
// setting the initialRoute and the onGenerateRoute for generating the routes from router.dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        Locale('de', ''),
        Locale('en', ''),
      ],
      locale: Locale('de'),
      title: 'BestFitnesstrackerEU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Open Sans'
        ),
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: InformationRoute,
    );
  }
}
