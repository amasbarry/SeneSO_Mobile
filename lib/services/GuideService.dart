import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso/models/tache_suivi_model.dart';

class TacheSuiviService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'tachesSuivi'; // Nom de la collection Firestore

  // Méthode pour ajouter une tâche de suivi
  Future<void> ajouterTache(TacheSuivi tache) async {
    try {
      // Valider les données de la tâche avant de l'ajouter
      tache.validerTache();
      await _firestore.collection(collectionName).add(tache.toMap());
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout de la tâche : $e');
    }
  }

  // Méthode pour mettre à jour une tâche de suivi
  Future<void> mettreAJourTache(TacheSuivi tache) async {
    try {
      // Valider les données de la tâche avant de la mettre à jour
      tache.validerTache();
      await _firestore.collection(collectionName).doc(tache.id).update(tache.toMap());
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour de la tâche : $e');
    }
  }

  // Méthode pour récupérer toutes les tâches de suivi
  Future<List<TacheSuivi>> recupererTaches() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) => TacheSuivi.fromDocument(doc)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des tâches : $e');
    }
  }

  // Méthode pour supprimer une tâche de suivi
  Future<void> supprimerTache(String id) async {
    try {
      await _firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      throw Exception('Erreur lors de la suppression de la tâche : $e');
    }
  }
}
