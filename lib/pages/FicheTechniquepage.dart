import 'package:flutter/material.dart';
import 'package:seneso/models/fichetechnique_model.dart';
import 'package:seneso/pages/profil_page.dart';
// Importez la page ProfilPage
import 'package:seneso/services/FicheTechniqueService.dart';
import 'DetailficheTechnique.dart';

class FicheTechniquepage extends StatefulWidget {
  const FicheTechniquepage({super.key});

  @override
  State<FicheTechniquepage> createState() => _FicheTechniquepageState();
}

class _FicheTechniquepageState extends State<FicheTechniquepage> {
  final FicheTechniqueService _ficheTechniqueService = FicheTechniqueService();
  List<FicheTechnique> _fiches = [];

  @override
  void initState() {
    super.initState();
    _loadFiches();
  }

  Future<void> _loadFiches() async {
    try {
      List<FicheTechnique> fiches = await _ficheTechniqueService.getAllFiches();
      setState(() {
        _fiches = fiches;
      });
    } catch (e) {
      print('Erreur lors du chargement des fiches techniques : $e');
    }
  }



  // Action pour afficher les détails d'une fiche technique
  void _afficherDetails(FicheTechnique fiche) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FicheDetailsPage(fiche: fiche),
      ),
    );
  }

  // Action pour modifier une fiche technique (ouvrir le formulaire avec des données pré-remplies)


  // Action pour supprimer une fiche technique
  Future<void> _supprimerFiche(String? id) async {
    if (id == null || id.isEmpty) {
      print('Erreur : L\'ID de la fiche est vide');
      return;
    }

    try {
      await _ficheTechniqueService.deleteFiche(id);
      _loadFiches(); // Recharger la liste après suppression
    } catch (e) {
      print('Erreur lors de la suppression de la fiche : $e');
    }
  }

  // Naviguer vers la page de profil
  void _naviguerVersProfil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilPage(), // Page de profil
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des fiches techniques'),
        actions: [
          // Ajouter un bouton pour naviguer vers la page de profil
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: _naviguerVersProfil,
            tooltip: 'Mon Profil', // Tooltip pour l'icône
          ),
        ],
      ),
      body: _fiches.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _fiches.length,
        itemBuilder: (context, index) {
          FicheTechnique fiche = _fiches[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: fiche.image != null && fiche.image!.isNotEmpty
                    ? NetworkImage(
                    fiche.image!) // Assurez-vous que `image` est un URL
                    : const AssetImage(
                    'assets/images/default_image.png') as ImageProvider,
                // Image par défaut si pas d'image
                radius: 30, // Ajustez le rayon selon vos besoins
              ),
              title: Text(fiche.nom),
              subtitle: Text(fiche.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () => _afficherDetails(fiche),
                    tooltip: 'Afficher les détails',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      
    );
  }
}
