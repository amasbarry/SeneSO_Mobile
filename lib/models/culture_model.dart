import 'package:cloud_firestore/cloud_firestore.dart';

class Culture {
  String id;
  String nom;
  String type; // Par exemple : légumes, fruits, céréales
  DateTime datePlantation;
  DateTime? dateRecolte; // Peut être null si la récolte n'a pas encore eu lieu
  double surface; // Surface en hectares ou en mètres carrés
  String utilisateurId; // Référence à l'utilisateur qui suit cette culture
  String ficheTechniqueId; // Référence à la fiche technique associée

  Culture({
    required this.id,
    required this.nom,
    required this.type,
    required this.datePlantation,
    this.dateRecolte,
    required this.surface,
    required this.utilisateurId,
    required this.ficheTechniqueId, // Lier la culture à la fiche technique
  });

  // Méthode pour convertir une culture depuis un document Firestore
  factory Culture.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Culture(
      id: doc.id,
      nom: data['nom'],
      type: data['type'],
      datePlantation: (data['datePlantation'] as Timestamp).toDate(),
      dateRecolte: data['dateRecolte'] != null ? (data['dateRecolte'] as Timestamp).toDate() : null,
      surface: data['surface'],
      utilisateurId: data['utilisateurId'],
      ficheTechniqueId: data['ficheTechniqueId'], // Ajouter ici
    );
  }

  // Méthode pour convertir une culture en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'type': type,
      'datePlantation': datePlantation,
      'dateRecolte': dateRecolte,
      'surface': surface,
      'utilisateurId': utilisateurId,
      'ficheTechniqueId': ficheTechniqueId, // Ajouter ici
    };
  }

  // Getters
  String get getId => id;
  String get getNom => nom;
  String get getType => type;
  DateTime get getDatePlantation => datePlantation;
  DateTime? get getDateRecolte => dateRecolte;
  double get getSurface => surface;
  String get getUtilisateurId => utilisateurId;
  String get getFicheTechniqueId => ficheTechniqueId; // Getter pour ficheTechniqueId
}
