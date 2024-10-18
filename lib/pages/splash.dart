import 'package:flutter/material.dart';
import 'package:seneso/pages/splash1.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Image d'arrière-plan
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png', // L'image de fond (framboises)
              fit: BoxFit.cover,
            ),
          ),
          // Contenu principal (logo, texte et bouton)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              // Logo avec texte
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      const Positioned(
                        top: -5,
                        child: Image(
                          height: 240,
                        image: AssetImage('assets/images/women.png')
                         ),
                      ),

                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 200),
                      height: 350,
                
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          // Logo et texte Sénêso
                          const SizedBox(height: 16),
                          Image.asset(
                            'assets/images/logoseneso.png', // Le logo Sénêso
                            height: 90,
                          ),
                          // const SizedBox(height: 16),
                          const Spacer(),
                          // Titre
                          const Text(
                            'Aw bisimila',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Sous-titre
                          const Text(
                            'Une récolte réussie commence ici. Explorez des guides et des conseils adaptés à vos cultures.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 20),
                          // Bouton avec flèche
                          IconButton(
                            onPressed: () {
                             Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> const Demarrage()),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Color.fromARGB(255, 12, 78, 56),
                              size: 30,
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
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: WelcomePage(),
  ));
}
