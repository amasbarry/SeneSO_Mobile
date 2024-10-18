import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String message;
  String userId; // L'utilisateur à qui la notification est envoyée
  DateTime dateEnvoi;

  NotificationModel({
    required this.id,
    required this.message,
    required this.userId,
    required this.dateEnvoi,
  });

  // Méthode pour convertir une notification depuis un document Firestore
  factory NotificationModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      message: data['message'],
      userId: data['userId'],
      dateEnvoi: (data['dateEnvoi'] as Timestamp).toDate(),
    );
  }

  // Méthode pour convertir une notification en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'userId': userId,
      'dateEnvoi': dateEnvoi,
    };
  }
}
