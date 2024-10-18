import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  String id;
  String nom;
  String prenom;
  String password;
  String email;
  String role; // Le rôle peut être agriculteur, administrateur ou partenaire

  Utilisateur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.password,
    required this.email,
    required this.role,
  });

  // Méthode pour convertir un utilisateur depuis un document Firestore
  factory Utilisateur.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Utilisateur(
      id: doc.id,
      nom: data['nom'],
      prenom: data['prenom'],
      password: data['password'], // Mot de passe non recommandé d'être stocké directement
      email: data['email'],
      role: data['role'],
    );
  }

  // Méthode pour convertir un utilisateur en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'role': role,
      // Ne pas stocker le mot de passe pour la sécurité
    };
  }
}
