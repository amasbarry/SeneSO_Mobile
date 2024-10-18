import 'package:cloud_firestore/cloud_firestore.dart';
import 'culturesuivi.dart'; // Assurez-vous que ce chemin est correct.

class ProfilUtilisateur {
  String id; // ID du profil utilisateur
  String userId; // Référence à l'utilisateur associé (ID de l'utilisateur dans la collection utilisateurs)

  String typeExploitation; // Type d'exploitation (ex: agriculture, élevage)
  List<String> culturesPrincipales; // Liste des cultures principales
  String region; // Région de l'utilisateur
  List<CultureSuivi> suivis; // Liste des suivis de cultures

  ProfilUtilisateur({
    required this.id,
    required this.userId,
    required this.typeExploitation,
    required this.culturesPrincipales,
    required this.region,
    required this.suivis,
  });

  // Méthode pour valider le profil utilisateur
  bool validate() {
    return id.isNotEmpty &&
        userId.isNotEmpty &&
        typeExploitation.isNotEmpty &&
        culturesPrincipales.isNotEmpty &&
        region.isNotEmpty &&
        suivis.every((suivi) => suivi.dateRecolte.isAfter(suivi.datePlantation)); // Vérification des dates dans les suivis
  }

  // Méthode pour convertir l'objet en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'typeExploitation': typeExploitation,
      'culturesPrincipales': culturesPrincipales,
      'region': region,
      'suivis': suivis.map((suivi) => suivi.toMap()).toList(), // Conversion des suivis
    };
  }

  // Méthode statique pour créer une instance à partir d'une map
  factory ProfilUtilisateur.fromMap(Map<String, dynamic> map) {
    return ProfilUtilisateur(
      id: map['id'],
      userId: map['userId'],
      typeExploitation: map['typeExploitation'],
      culturesPrincipales: List<String>.from(map['culturesPrincipales']),
      region: map['region'],
      suivis: List<CultureSuivi>.from(
          map['suivis'].map((suivi) => CultureSuivi.fromMap(suivi))),
    );
  }

  // Méthode pour créer une instance à partir d'un DocumentSnapshot
  factory ProfilUtilisateur.fromDocument(DocumentSnapshot doc) {
    return ProfilUtilisateur.fromMap(doc.data() as Map<String, dynamic>);
  }

  // Getters
  String get getId => id;
  String get getUserId => userId;
  String get getTypeExploitation => typeExploitation;
  List<String> get getCulturesPrincipales => culturesPrincipales;
  String get getRegion => region;
  List<CultureSuivi> get getSuivis => suivis;
}
