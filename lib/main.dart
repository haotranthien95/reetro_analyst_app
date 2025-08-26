import 'package:flutter/material.dart';
import 'package:reetro_analyst_app/core/local/shared_ref.dart';

import 'package:reetro_analyst_app/di.dart';

import 'package:reetro_analyst_app/presentation/login/login_screen.dart';
import 'package:reetro_analyst_app/presentation/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

late final BuildContext appContext;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    appContext = context;
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Reetro Analyst',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
