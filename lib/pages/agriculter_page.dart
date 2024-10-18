import 'package:flutter/material.dart';

class AgriculterPage extends StatelessWidget {
  const AgriculterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page d\'Agriculture'),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenue dans l\'espace Agricole',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sélectionnez une option pour commencer :',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            // Liste de boutons pour accéder aux différentes sections
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Code pour rediriger vers une autre page ou fonction
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CulturesPage()),
                );
              },
              child: const Text(
                'Gérer les Cultures',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Code pour rediriger vers une autre page ou fonction
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProduitsPage()),
                );
              },
              child: const Text(
                'Gérer les Produits',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Code pour rediriger vers une autre page ou fonction
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TachesPage()),
                );
              },
              child: const Text(
                'Voir les Tâches',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CulturesPage extends StatelessWidget {
  const CulturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cultures'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: const Text('Page de gestion des cultures'),
      ),
    );
  }
}

class ProduitsPage extends StatelessWidget {
  const ProduitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits Agricoles'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: const Text('Page de gestion des produits agricoles'),
      ),
    );
  }
}

class TachesPage extends StatelessWidget {
  const TachesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tâches Agricoles'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: const Text('Page des tâches agricoles'),
      ),
    );
  }
}
