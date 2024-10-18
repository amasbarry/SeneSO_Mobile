import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class Agriculteur extends Utilisateur {
  String typeExploitation; // Amateur ou Professionnel
  List<String> culturesSuivies; // Liste des cultures principales
  String region; // Région de l'agriculteur

  Agriculteur({
    required String id,
    required String nom,
    required String prenom,
    required String password,
    required String email,
    required String role, // "agriculteur"
    required this.typeExploitation,
    required this.culturesSuivies,
    required this.region,
  }) : super(id: id, nom: nom, prenom: prenom, password: password, email: email, role: role);

  // Méthode pour convertir un agriculteur depuis un document Firestore
  factory Agriculteur.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return Agriculteur(
      id: doc.id,
      nom: data['nom'] ?? '',
      prenom: data['prenom'] ?? '',
      password: data['password'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'agriculteur', // Valeur par défaut
      typeExploitation: data['typeExploitation'] ?? '',
      culturesSuivies: List<String>.from(data['culturesSuivies'] ?? []),
      region: data['region'] ?? '',
    );
  }

  // Méthode pour convertir un agriculteur en format Map (pour Firestore)
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'typeExploitation': typeExploitation,
      'culturesSuivies': culturesSuivies,
      'region': region,
    });
    return map;
  }
}
