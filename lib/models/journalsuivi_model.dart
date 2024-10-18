import 'package:cloud_firestore/cloud_firestore.dart';

class JournalSuivi {
  String id; // ID du journal de suivi
  String cultureId; // Référence à la culture associée
  DateTime date; // Date du suivi
  String description; // Description des actions réalisées (ex : arrosage, fertilisation)
  String etatCulture; // État actuel de la culture (ex : croissance, floraison, récolte)
  String pesticideUtilise; // Pesticide utilisé
  double? quantiteEau; // Quantité d'eau utilisée (peut être null si non concerné)
  String utilisateurId; // Référence à l'utilisateur qui a effectué ce suivi

  JournalSuivi({
    required this.id,
    required this.cultureId,
    required this.date,
    required this.description,
    required this.etatCulture,
    required this.pesticideUtilise,
    this.quantiteEau,
    required this.utilisateurId,
  });

  // Méthode pour convertir un journal de suivi depuis un document Firestore
  factory JournalSuivi.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return JournalSuivi(
      id: doc.id,
      cultureId: data['cultureId'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      description: data['description'] ?? '',
      etatCulture: data['etatCulture'] ?? '',
      pesticideUtilise: data['pesticideUtilise'] ?? '',
      quantiteEau: data['quantiteEau']?.toDouble(),
      utilisateurId: data['utilisateurId'] ?? '',
    );
  }

  // Méthode pour convertir un journal de suivi en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'cultureId': cultureId,
      'date': Timestamp.fromDate(date),
      'description': description,
      'etatCulture': etatCulture,
      'pesticideUtilise': pesticideUtilise,
      'quantiteEau': quantiteEau,
      'utilisateurId': utilisateurId,
    };
  }
}
