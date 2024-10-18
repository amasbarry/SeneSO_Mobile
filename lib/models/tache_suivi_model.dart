import 'package:cloud_firestore/cloud_firestore.dart';

class TacheSuivi {
  String id;
  String cultureId; // Référence à la culture associée
  String titre;
  String description;
  DateTime date;
  bool estComplete; // Statut de la tâche
  List<String> etapes; // Liste des étapes à suivre (préparation, semis, entretien, récolte)

  TacheSuivi({
    required this.id,
    required this.cultureId,
    required this.titre,
    required this.description,
    required this.date,
    required this.estComplete,
    required this.etapes,
  });

  // Méthode pour convertir une tâche de suivi depuis un document Firestore
  factory TacheSuivi.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TacheSuivi(
      id: doc.id,
      cultureId: data['cultureId'],
      titre: data['titre'],
      description: data['description'],
      date: (data['date'] as Timestamp).toDate(),
      estComplete: data['estComplete'],
      etapes: List<String>.from(data['etapes'] ?? []),
    );
  }

  // Méthode pour convertir une tâche de suivi en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'cultureId': cultureId,
      'titre': titre,
      'description': description,
      'date': date,
      'estComplete': estComplete,
      'etapes': etapes,
    };
  }

  // Méthode pour marquer une étape comme complétée
  void marquerEtapeComplete(String etape) {
    if (etapes.contains(etape)) {
      etapes.remove(etape);
      estComplete = etapes.isEmpty; // Marquer la tâche comme complétée si toutes les étapes sont complètes
    } else {
      throw Exception('L\'étape fournie n\'existe pas dans la liste des étapes.');
    }
  }

  // Méthode pour valider les données de la tâche
  void validerTache() {
    if (titre.isEmpty) {
      throw Exception('Le titre de la tâche ne peut pas être vide.');
    }
    if (description.isEmpty) {
      throw Exception('La description de la tâche ne peut pas être vide.');
    }
    if (etapes.isEmpty) {
      throw Exception('La liste des étapes ne peut pas être vide.');
    }
    if (date.isBefore(DateTime.now())) {
      throw Exception('La date de la tâche ne peut pas être dans le passé.');
    }
  }
}
