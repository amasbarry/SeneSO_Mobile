class CultureSuivi {
  String id; // ID de la culture
  String cultureId; // Référence à l'ID de la culture
  DateTime datePlantation; // Date de plantation
  DateTime dateRecolte; // Date de récolte prévue

  CultureSuivi({
    required this.id,
    required this.cultureId,
    required this.datePlantation,
    required this.dateRecolte,
  }) {
    // Validation des dates
    if (dateRecolte.isBefore(datePlantation)) {
      throw Exception("La date de récolte ne peut pas être antérieure à la date de plantation.");
    }
  }

  // Méthode pour convertir l'objet CultureSuivi en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cultureId': cultureId, // Référence à la culture
      'datePlantation': datePlantation.toIso8601String(),
      'dateRecolte': dateRecolte.toIso8601String(),
    };
  }

  // Méthode pour créer un objet CultureSuivi à partir d'un Map
  factory CultureSuivi.fromMap(Map<String, dynamic> data) {
    return CultureSuivi(
      id: data['id'] ?? '',
      cultureId: data['cultureId'] ?? '',
      datePlantation: DateTime.parse(data['datePlantation'] ?? DateTime.now().toIso8601String()),
      dateRecolte: DateTime.parse(data['dateRecolte'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Getters
  String get getId => id;
  String get getCultureId => cultureId; // Getter pour cultureId
  DateTime get getDatePlantation => datePlantation;
  DateTime get getDateRecolte => dateRecolte;
}

class ProfilUtilisateur {
  String id; // ID du profil utilisateur
  String userId; // Référence à l'utilisateur associé
  String typeExploitation; // Type d'exploitation (ex: agriculture, élevage)
  List<String> culturesPrincipales; // Liste des cultures principales
  String region; // Région de l'utilisateur
  List<CultureSuivi> suivis; // Liste des suivis de cultures

  ProfilUtilisateur({
    required this.id,
    required this.userId,
    required this.typeExploitation,
    required this.culturesPrincipales,
    required this.region,
    required this.suivis,
  });

  // Méthode pour valider le profil utilisateur
  bool validate() {
    return id.isNotEmpty &&
        userId.isNotEmpty &&
        typeExploitation.isNotEmpty &&
        culturesPrincipales.isNotEmpty &&
        region.isNotEmpty &&
        suivis.every((suivi) => suivi.dateRecolte.isAfter(suivi.datePlantation)); // Vérification des dates dans les suivis
  }

  // Méthode pour convertir en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'typeExploitation': typeExploitation,
      'culturesPrincipales': culturesPrincipales,
      'region': region,
      'suivis': suivis.map((suivi) => suivi.toMap()).toList(),
    };
  }

  // Méthode statique pour créer une instance à partir d'une map
  factory ProfilUtilisateur.fromMap(Map<String, dynamic> map) {
    return ProfilUtilisateur(
      id: map['id'],
      userId: map['userId'],
      typeExploitation: map['typeExploitation'],
      culturesPrincipales: List<String>.from(map['culturesPrincipales']),
      region: map['region'],
      suivis: List<CultureSuivi>.from(
          map['suivis'].map((suivi) => CultureSuivi.fromMap(suivi))),
    );
  }

  // Getters
  String get getId => id;
  String get getUserId => userId;
  String get getTypeExploitation => typeExploitation;
  List<String> get getCulturesPrincipales => culturesPrincipales;
  String get getRegion => region;
  List<CultureSuivi> get getSuivis => suivis;
}
