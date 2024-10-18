import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class Partenaire extends Utilisateur {
  String entreprise; // Nom de l'entreprise du partenaire
  String secteur; // Secteur d'activité du partenaire (ex : semences, fertilisants)

  Partenaire({
    required String id,
    required String nom,
    required String prenom,
    required String password,
    required String email,
    required String role, // "partenaire"
    required this.entreprise,
    required this.secteur,
  }) : super(id: id, nom: nom, prenom: prenom, password: password, email: email, role: role);

  // Convertir un document Firestore en objet Partenaire
  factory Partenaire.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Partenaire(
      id: doc.id,
      nom: data['nom'],
      prenom: data['prenom'],
      password: data['password'],
      email: data['email'],
      role: data['role'],
      entreprise: data['entreprise'],
      secteur: data['secteur'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'entreprise': entreprise,
      'secteur': secteur,
    });
    return map;
  }
}
