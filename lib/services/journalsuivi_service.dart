import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso/models/journalsuivi_model.dart';


class JournalSuiviService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Créer un nouveau journal de suivi
  Future<void> createJournal(JournalSuivi journal) async {
    await _firestore.collection('journauxSuivi').add(journal.toMap());
  }

  // Lire tous les journaux de suivi
  Future<List<JournalSuivi>> getAllJournaux() async {
    QuerySnapshot snapshot = await _firestore.collection('journauxSuivi').get();
    return snapshot.docs.map((doc) => JournalSuivi.fromDocument(doc)).toList();
  }

  // Lire les journaux de suivi par culture
  Future<List<JournalSuivi>> getJournauxByCulture(String cultureId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('journauxSuivi')
        .where('cultureId', isEqualTo: cultureId)
        .get();
    return snapshot.docs.map((doc) => JournalSuivi.fromDocument(doc)).toList();
  }

  // Mettre à jour un journal de suivi
  Future<void> updateJournal(JournalSuivi journal) async {
    await _firestore.collection('journauxSuivi').doc(journal.id).update(journal.toMap());
  }

  // Supprimer un journal de suivi
  Future<void> deleteJournal(String id) async {
    await _firestore.collection('journauxSuivi').doc(id).delete();
  }

  // Récupérer les journaux de suivi par utilisateur
  Future<List<JournalSuivi>> getJournauxByUtilisateur(String utilisateurId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('journauxSuivi')
        .where('utilisateurId', isEqualTo: utilisateurId)
        .get();
    return snapshot.docs.map((doc) => JournalSuivi.fromDocument(doc)).toList();
  }

  // Récupérer les journaux de suivi par date
  Future<List<JournalSuivi>> getJournauxByDate(DateTime date) async {
    QuerySnapshot snapshot = await _firestore
        .collection('journauxSuivi')
        .where('date', isEqualTo: Timestamp.fromDate(date))
        .get();
    return snapshot.docs.map((doc) => JournalSuivi.fromDocument(doc)).toList();
  }
}
