import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso/models/fichetechnique_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FicheTechniqueService {
  final CollectionReference ficheCollection = FirebaseFirestore.instance.collection('fichesTechniques');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Ajouter une fiche technique
  Future<String> ajouterFiche(FicheTechnique fiche) async {
    try {
      DocumentReference docRef = await ficheCollection.add(fiche.toMap());
      print("Fiche technique ajoutée avec succès avec l'ID: ${docRef.id}");
      return docRef.id;
    } catch (e) {
      print("Erreur lors de l'ajout de la fiche technique: $e");
      throw e;
    }
  }

  // Méthode pour l'upload d'image à partir d'un chemin (Web uniquement)


  // Méthode pour télécharger des bytes (Web uniquement)
  Future<String> uploadImageFromBytes(Uint8List bytes) async {
    try {
      String filePath = 'images/${DateTime.now().millisecondsSinceEpoch}.png';
      final ref = _storage.ref(filePath);
      await ref.putData(bytes);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Erreur lors de l\'upload de l\'image: $e');
      throw Exception('Erreur lors de l\'upload de l\'image');
    }
  }

  // Récupérer une fiche technique par ID
  Future<FicheTechnique?> getFicheById(String id) async {
    try {
      DocumentSnapshot doc = await ficheCollection.doc(id).get();
      if (doc.exists) {
        return FicheTechnique.fromDocument(doc);
      } else {
        print("Fiche technique introuvable");
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération de la fiche technique: $e");
      throw e;
    }
  }

  // Mettre à jour une fiche technique
  Future<void> updateFiche(FicheTechnique fiche) async {
    try {
      await ficheCollection.doc(fiche.id).update(fiche.toMap());
      print("Fiche technique mise à jour avec succès");
    } catch (e) {
      print("Erreur lors de la mise à jour de la fiche technique: $e");
      throw e;
    }
  }

  // Supprimer une fiche technique
  Future<void> deleteFiche(String id) async {
    try {
      await ficheCollection.doc(id).delete();
      print("Fiche technique supprimée avec succès");
    } catch (e) {
      print("Erreur lors de la suppression de la fiche technique: $e");
      throw e;
    }
  }



  // Récupérer toutes les fiches techniques
  Future<List<FicheTechnique>> getAllFiches() async {
    try {
      QuerySnapshot querySnapshot = await ficheCollection.get();
      return querySnapshot.docs.map((doc) => FicheTechnique.fromDocument(doc)).toList();
    } catch (e) {
      print("Erreur lors de la récupération des fiches techniques: $e");
      throw e;
    }
  }

  // Rechercher des fiches techniques par nom
  Future<List<FicheTechnique>> rechercherParNom(String nom) async {
    try {
      QuerySnapshot querySnapshot = await ficheCollection.where('nom', isEqualTo: nom).get();
      return querySnapshot.docs.map((doc) => FicheTechnique.fromDocument(doc)).toList();
    } catch (e) {
      print("Erreur lors de la recherche par nom: $e");
      throw e;
    }
  }

  // Recherche multi-critères avec plusieurs filtres
  Future<List<FicheTechnique>> rechercherMultiCriteres({
    String? nom,
    String? famille,
    String? saison,
    double? minPH,
    double? maxPH,
    String? region,
  }) async {
    try {
      Query query = ficheCollection;

      if (nom != null && nom.isNotEmpty) query = query.where('nom', isEqualTo: nom);
      if (famille != null && famille.isNotEmpty) query = query.where('famille', isEqualTo: famille);
      if (saison != null && saison.isNotEmpty) query = query.where('saison', isEqualTo: saison);
      if (minPH != null) query = query.where('pH', isGreaterThanOrEqualTo: minPH);
      if (maxPH != null) query = query.where('pH', isLessThanOrEqualTo: maxPH);
      if (region != null && region.isNotEmpty) query = query.where('zoneGeographique', isEqualTo: region);

      QuerySnapshot querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) => FicheTechnique.fromDocument(doc)).toList();
    } catch (e) {
      print("Erreur lors de la recherche multi-critères: $e");
      throw e;
    }
  }
}
