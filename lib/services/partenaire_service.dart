import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso/models/partenaire_model.dart';


class PartenaireService {
  final CollectionReference partenairesCollection = FirebaseFirestore.instance.collection('partenaires');

  // Ajouter un partenaire
  Future<void> creerPartenaire(Partenaire partenaire) async {
    await partenairesCollection.doc(partenaire.id).set(partenaire.toMap());
  }

  // Récupérer un partenaire par ID
  Future<Partenaire?> getPartenaireParId(String id) async {
    DocumentSnapshot doc = await partenairesCollection.doc(id).get();
    if (doc.exists) {
      return Partenaire.fromDocument(doc);
    }
    return null;
  }

  // Mettre à jour un partenaire
  Future<void> mettreAJourPartenaire(Partenaire partenaire) async {
    await partenairesCollection.doc(partenaire.id).update(partenaire.toMap());
  }

  // Supprimer un partenaire
  Future<void> supprimerPartenaire(String id) async {
    await partenairesCollection.doc(id).delete();
  }
}
