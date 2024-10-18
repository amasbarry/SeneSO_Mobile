import 'package:flutter/material.dart';
import 'package:seneso/pages/splash.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    // Délai de 3 secondes avant de naviguer vers la page Splash
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()), // Assurez-vous que SplashPage est défini dans splash.dart
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          height: 150,
          image: AssetImage('assets/images/logoseneso.png'),
        ),
      ),
    );
  }
}
