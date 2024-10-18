import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  const Page404({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page non autorisée"),
        backgroundColor: Colors.red[800],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Erreur 404: Page non trouvée',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Désolé, vous n\'êtes pas autorisé à accéder à cette page.',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
