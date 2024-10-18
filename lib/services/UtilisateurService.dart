import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seneso/models/admin_model.dart';
import 'package:seneso/models/agriculteur_model.dart';
import 'package:seneso/models/user_model.dart';


class UtilisateurService {
  final CollectionReference utilisateursCollection = FirebaseFirestore.instance.collection('users');

  // Créer un nouvel utilisateur (Agriculteur, Administrateur ou Partenaire)
  Future<void> creerUtilisateur(Utilisateur utilisateur) async {
    await utilisateursCollection.doc(utilisateur.id).set(utilisateur.toMap());
  }

  // Récupérer un utilisateur par ID
  Future<Utilisateur?> getUtilisateurParId(String id) async {
    DocumentSnapshot doc = await utilisateursCollection.doc(id).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['role'] == 'agriculteur') {
        return Agriculteur.fromDocument(doc);
      } else if (data['role'] == 'administrateur') {
        return Administrateur.fromDocument(doc);
      }
    }
    return null;
  }

  // Récupérer tous les agriculteurs
  Future<List<Agriculteur>> getTousLesAgriculteurs() async {
    QuerySnapshot snapshot = await utilisateursCollection.where('role', isEqualTo: 'agriculteur').get();
    return snapshot.docs.map((doc) => Agriculteur.fromDocument(doc)).toList();
  }

  // Méthode pour authentifier un utilisateur
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        print("Connexion réussie : ${user.email}");
        return user;
      }
    } on FirebaseAuthException catch (e) {
      print("Erreur lors de la connexion : $e");
    }
    return null;
  }

  // Mettre à jour un utilisateur
  Future<void> mettreAJourUtilisateur(Utilisateur utilisateur) async {
    await utilisateursCollection.doc(utilisateur.id).update(utilisateur.toMap());
  }

  // Supprimer un utilisateur
  Future<void> supprimerUtilisateur(String id) async {
    await utilisateursCollection.doc(id).delete();
  }
}
