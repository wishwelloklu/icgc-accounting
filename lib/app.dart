import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accounting_app/app/config/navigation_key.dart';
import 'package:accounting_app/app/routes/app_routes.dart';
import 'package:accounting_app/app/routes/routes.dart';
import 'package:accounting_app/route_observer.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        title: 'Accounting',
        scaffoldMessengerKey: AppNavigatorKeys.instance.scaffoldKey,
        navigatorKey: AppNavigatorKeys.instance.navigatorKey,
        onGenerateRoute: (settings) => Routes.onGenerateRoutes(settings),
        initialRoute: AppRoutes.splash,
        navigatorObservers: [AppRouteObserver()],
      ),
    );
  }
}
