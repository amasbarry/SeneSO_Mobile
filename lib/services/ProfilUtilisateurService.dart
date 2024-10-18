import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/agriculteur_model.dart';

class ProfilService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collection = 'profils_agriculteurs';

  // Créer ou mettre à jour un profil d'agriculteur
  Future<void> createOrUpdateProfil(Agriculteur agriculteur) async {
    await _firestore.collection(collection).doc(agriculteur.id).set(agriculteur.toMap());
  }

  // Récupérer le profil d'un agriculteur par ID
  Future<Agriculteur?> getProfilAgriculteur(String id) async {
    DocumentSnapshot doc = await _firestore.collection(collection).doc(id).get();
    if (doc.exists) {
      return Agriculteur.fromDocument(doc);
    }
    return null;
  }

  // Supprimer un profil d'agriculteur
  Future<void> deleteProfil(String id) async {
    await _firestore.collection(collection).doc(id).delete();
  }
}
