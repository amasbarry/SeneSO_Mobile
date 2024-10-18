import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seneso/models/fichetechnique_model.dart';
import 'suivi_culture_page.dart'; // Import de la nouvelle page SuiviCulturePage

class FicheDetailsPage extends StatelessWidget {
  final FicheTechnique fiche;

  const FicheDetailsPage({Key? key, required this.fiche}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fiche.nom, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section pour l'image
              if (fiche.image.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      fiche.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Informations générales
              _buildSectionCard(
                title: 'Informations Générales',
                icon: FontAwesomeIcons.leaf,
                color: Colors.green.shade700,
                children: [
                  _buildInfoRow(Icons.nature, 'Nom', fiche.nom),
                  _buildInfoRow(Icons.description, 'Description', fiche.description),
                  _buildInfoRow(Icons.family_restroom, 'Famille', fiche.famille),
                  _buildInfoRow(Icons.water, 'Besoins en eau', fiche.besoinsEnEau.join(", ")),
                  _buildInfoRow(FontAwesomeIcons.seedling, 'pH du sol', fiche.pH.toString()),
                  _buildInfoRow(Icons.calendar_today, 'Saison', fiche.saison),
                ],
              ),
              
              const SizedBox(height: 20),

              // Conditions de culture
              _buildSectionCard(
                title: 'Conditions de Culture',
                icon: FontAwesomeIcons.tractor,
                color: Colors.brown.shade700,
                children: [
                  _buildInfoRow(Icons.grass, 'Type de sol', fiche.typeSol),
                  _buildInfoRow(Icons.wb_sunny, 'Exposition', fiche.exposition),
                  _buildInfoRow(FontAwesomeIcons.recycle, 'Cycle de culture', fiche.cycleDeCulture),
                  _buildInfoRow(Icons.thermostat, 'Température optimale', fiche.temperatureOptimale),
                  _buildInfoRow(Icons.opacity, 'Humidité optimale', fiche.humidityOptimale),
                  _buildInfoRow(Icons.format_list_numbered, 'Étapes de culture', fiche.etapes.join(", ")),
                ],
              ),

              const SizedBox(height: 20),

              // Bouton de navigation
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigation vers SuiviCulturePage avec l'objet fiche
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuiviCulturePage(fiche: fiche),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700, // Couleur du bouton
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Voir Suivi de Culture'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour construire les sections avec des informations
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  // Méthode pour construire une ligne avec des informations spécifiques
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.green.shade700),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '$label : $value',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
