import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _nom;
  late String _prenom;
  late String _email;
  late String _typeExploitation;
  late String _culturesPrincipales;
  late String _region;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _typeExploitationController = TextEditingController();
  TextEditingController _culturesPrincipalesController = TextEditingController();
  TextEditingController _regionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  // Fonction pour récupérer les informations de l'utilisateur
  Future<void> _getUserInfo() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          _nom = userDoc['nom'];
          _prenom = userDoc['prenom'];
          _email = userDoc['email'];
          _typeExploitation = userDoc['typeExploitation'];
          _culturesPrincipales = userDoc['culturesPrincipales'];
          _region = userDoc['region'];

          // Initialisation des contrôleurs avec les données existantes
          _nomController.text = _nom;
          _prenomController.text = _prenom;
          _emailController.text = _email;
          _typeExploitationController.text = _typeExploitation;
          _culturesPrincipalesController.text = _culturesPrincipales;
          _regionController.text = _region;
        });
      }
    }
  }

  // Fonction pour mettre à jour les informations de l'utilisateur
  Future<void> _updateUserInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        User? user = _auth.currentUser;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).update({
            'nom': _nomController.text,
            'prenom': _prenomController.text,
            'email': _emailController.text,
            'typeExploitation': _typeExploitationController.text,
            'culturesPrincipales': _culturesPrincipalesController.text,
            'region': _regionController.text,
          });

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Informations mises à jour avec succès.")));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur lors de la mise à jour : ${e.toString()}")));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier Profil"),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Champ Nom
                TextFormField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                  validator: (value) => value!.isEmpty ? 'Le nom est requis' : null,
                ),
                // Champ Prénom
                TextFormField(
                  controller: _prenomController,
                  decoration: const InputDecoration(labelText: 'Prénom'),
                  validator: (value) => value!.isEmpty ? 'Le prénom est requis' : null,
                ),
                // Champ Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'L\'email est requis' : null,
                ),
                // Champ Type d'exploitation
                TextFormField(
                  controller: _typeExploitationController,
                  decoration: const InputDecoration(labelText: 'Type d\'exploitation'),
                  validator: (value) => value!.isEmpty ? 'Le type d\'exploitation est requis' : null,
                ),
                // Champ Cultures principales
                TextFormField(
                  controller: _culturesPrincipalesController,
                  decoration: const InputDecoration(labelText: 'Cultures principales'),
                  validator: (value) => value!.isEmpty ? 'Les cultures principales sont requises' : null,
                ),
                // Champ Région
                TextFormField(
                  controller: _regionController,
                  decoration: const InputDecoration(labelText: 'Région'),
                  validator: (value) => value!.isEmpty ? 'La région est requise' : null,
                ),
                const SizedBox(height: 20),
                // Bouton de sauvegarde
                ElevatedButton(
                  onPressed: _isLoading ? null : _updateUserInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Mettre à jour",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
