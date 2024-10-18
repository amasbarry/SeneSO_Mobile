import 'package:cloud_firestore/cloud_firestore.dart';

class EventAgricole {
  String id;
  String titre;
  String description;
  DateTime date;
  String userId; // L'utilisateur associé à cet événement
  String type; // Type de l'événement (atelier, fête, marché, etc.)
  String image; // URL de l'image associée à l'événement

  EventAgricole({
    required this.id,
    required this.titre,
    required this.description,
    required this.date,
    required this.userId,
    required this.type, // Ajout du type
    required this.image, // Ajout de l'image
  });

  // Méthode pour convertir un événement agricole depuis un document Firestore
  factory EventAgricole.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return EventAgricole(
      id: doc.id,
      titre: data['titre'],
      description: data['description'],
      date: (data['date'] as Timestamp).toDate(),
      userId: data['userId'],
      type: data['type'], // Récupération du type
      image: data['image'], // Récupération de l'image
    );
  }

  // Méthode pour convertir un événement agricole en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'description': description,
      'date': date,
      'userId': userId,
      'type': type, // Ajout du type
      'image': image, // Ajout de l'image
    };
  }
}
