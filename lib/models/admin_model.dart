import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class Administrateur extends Utilisateur {
  Administrateur({
    required super.id,
    required super.nom,
    required super.prenom,
    required super.password,
    required super.email,
    required super.role, // "administrateur"
  });

  // Méthode pour convertir un administrateur depuis un document Firestore
  factory Administrateur.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Administrateur(
      id: doc.id,
      nom: data['nom'],
      prenom: data['prenom'],
      password: data['password'],
      email: data['email'],
      role: data['role'],
    );
  }

  // Méthode pour convertir un administrateur en format Map (pour Firestore)
  @override
  Map<String, dynamic> toMap() {
    return super.toMap();
  }
}
