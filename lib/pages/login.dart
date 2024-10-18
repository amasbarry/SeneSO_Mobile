import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seneso/pages/FicheTechniquepage.dart';
import 'package:seneso/pages/agriculter_page.dart';  // Page Agriculteur
import 'package:seneso/pages/home.dart';
import 'package:seneso/pages/page404.dart';
import 'InscriptionPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  // Fonction de connexion
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Tentative de connexion avec email et mot de passe
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _motDePasseController.text.trim(),
      );

      // Récupérer l'utilisateur connecté
      User? user = userCredential.user;

      if (user != null) {
        // Récupérer le rôle de l'utilisateur
        String role = await _getUserRole(user);

        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? fcmToken = await messaging.getToken();

        // Mise à jour du token FCM dans Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'fcmToken': fcmToken, // Met à jour uniquement le champ fcmToken
        });

        // Redirection vers la page appropriée en fonction du rôle
        if (role == 'Agriculteur') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FicheTechniquepage()),
          );
        } else if (role == 'Administrateur') {
          // Redirection vers la page Admin
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Page404()),
          );
        } else {
          // Si le rôle n'est ni 'Agriculteur' ni 'Administrateur', on redirige vers une page 404
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Page404()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Utilisateur non trouvé ou erreur de connexion')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Aucun utilisateur trouvé pour cet email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mot de passe incorrect.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de connexion: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Fonction pour obtenir le rôle de l'utilisateur depuis Firestore
  Future<String> _getUserRole(User user) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      return userDoc['role'];
    } else {
      return 'Utilisateur'; // Rôle par défaut si non défini
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.png'), // Image de fond
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dégradé transparent
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.withOpacity(0.7),
                  Colors.green.withOpacity(0.4),
                ],
              ),
            ),
          ),
          // Contenu principal de la page
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bienvenue à',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/logoseneso2.png', // Logo
                    height: 100,
                  ),
                  const SizedBox(height: 30),
                  // Formulaire de connexion
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Connexion',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Champ Email
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email, color: Colors.green[800]),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Champ Mot de Passe
                        TextField(
                          controller: _motDePasseController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Mot de Passe',
                            prefixIcon: Icon(Icons.lock, color: Colors.green[800]),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Bouton de Connexion
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[800],
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _login,
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              'Se Connecter',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Lien d'inscription
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InscriptionPage()),
                            );
                          },
                          child: Text(
                            "Pas encore inscrit? Inscrivez-vous ici!",
                            style: TextStyle(color: Colors.green[800]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

