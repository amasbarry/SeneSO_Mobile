import 'package:cloud_firestore/cloud_firestore.dart';

class Guide {
  String id;
  String titre;
  String description;
  String categorie;
  DateTime datePublication; // Date de publication du guide
  String videoUrl; // URL de la vidéo associée au guide
  String? ficheTechniqueId; // Référence optionnelle à une fiche technique
  String? cultureId; // Référence optionnelle à une culture

  Guide({
    required this.id,
    required this.titre,
    required this.description,
    required this.categorie,
    required this.datePublication,
    required this.videoUrl,
    this.ficheTechniqueId,
    this.cultureId,
  }) {
    // Validation des données
    if (datePublication.isBefore(DateTime.now())) {
      throw ArgumentError('La date de publication ne peut pas être dans le passé.');
    }
    if (!videoUrl.startsWith('http://') && !videoUrl.startsWith('https://')) {
      throw ArgumentError('L\'URL de la vidéo doit commencer par http:// ou https://.');
    }
  }

  // Méthode pour convertir un guide depuis un document Firestore
  factory Guide.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Guide(
      id: doc.id,
      titre: data['titre'],
      description: data['description'],
      categorie: data['categorie'],
      datePublication: (data['datePublication'] as Timestamp).toDate(), // Conversion de la date
      videoUrl: data['videoUrl'],
      ficheTechniqueId: data['ficheTechniqueId'], // Récupération de l'ID de la fiche technique, si présent
      cultureId: data['cultureId'], // Récupération de l'ID de la culture, si présent
    );
  }

  // Méthode pour convertir un guide en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'description': description,
      'categorie': categorie,
      'datePublication': datePublication.toIso8601String(), // Conversion de la date en chaîne ISO
      'videoUrl': videoUrl,
      'ficheTechniqueId': ficheTechniqueId, // Ajout de l'ID de la fiche technique
      'cultureId': cultureId, // Ajout de l'ID de la culture
    };
  }
}
