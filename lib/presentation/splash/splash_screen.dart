import 'package:flutter/material.dart';

import 'package:reetro_analyst_app/core/local/shared_ref.dart';
import 'package:reetro_analyst_app/presentation/home/home_screen.dart';
import 'package:reetro_analyst_app/presentation/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenExisted();
  }

  _checkTokenExisted() async {
    await Future.delayed(Duration(milliseconds: 500));
    if ((prefs.getString('token') ?? "").isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const HomeScreen(title: "Reetro report")),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.red,
        body: Container());
  }
}
