import 'package:flutter/material.dart';
import 'package:seneso/pages/login.dart';


class Demarrage extends StatelessWidget {
  const Demarrage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      body: Stack(
        children: [
          // Image d'arrière-plan
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg1.png', // Image de fond
              fit: BoxFit.cover, // Remplissage de l'écran
            ),
          ),
          // Contenu principal : logo, texte et bouton
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
            crossAxisAlignment: CrossAxisAlignment.center, // Centrer horizontalement
            children: [
              const Spacer(), // Espace flexible avant le contenu

              // Logo et texte
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center, // Centrer le contenu
                    children: [
                      // Position du logo
                      const Positioned(
                        top: -5, // Légèrement au-dessus
                        child: Image(
                          height: 240, // Taille du logo
                          image: AssetImage('assets/images/agri.png'), // Chemin de l'image
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 200), // Espace avant le conteneur
                          height: 350, // Hauteur du conteneur
                          padding: const EdgeInsets.all(10.0), // Espacement intérieur
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9), // Fond blanc transparent
                            borderRadius: BorderRadius.circular(20.0), // Coins arrondis
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // Centre le contenu
                            children: [
                              const SizedBox(height: 8), // Espace au-dessus
                              
                              // Texte centré avec style
                              const Center(
                                child: Text(
                                  'Accédez à des techniques agricoles éprouvées pour maximiser vos rendements.',
                                  textAlign: TextAlign.center, // Centrer le texte
                                  style: TextStyle(
                                    fontSize: 24, // Taille de police
                                    color: Colors.black, // Couleur noire
                                    fontWeight: FontWeight.bold, // Texte en gras
                                  ),
                                ),
                              ),
                              const SizedBox(height: 60), // Plus d'espace avant le bouton "Continuer"
                              
                              // Bouton "Continuer"
                              ElevatedButton(
                                onPressed: () {
                                  // Ouvre la page de connexion lorsqu'on clique sur le bouton
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage ()), // Dirige vers la page de connexion
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange, // Couleur du bouton
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, // Espace vertical du bouton
                                    horizontal: 40.0, // Espace horizontal
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0), // Coins arrondis du bouton
                                  ),
                                ),
                                child: const Text(
                                  'Continuer',
                                  style: TextStyle(
                                    fontSize: 20, // Taille du texte du bouton
                                    fontWeight: FontWeight.bold, // Texte en gras
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(), // Espace après le contenu
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Demarrage(), // Lancer la page Demarrage
  ));
}
