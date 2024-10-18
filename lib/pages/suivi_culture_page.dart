import 'package:flutter/material.dart';
import 'package:seneso/models/fichetechnique_model.dart';

class SuiviCulturePage extends StatefulWidget {
  final FicheTechnique fiche;

  // Constructor pour accepter l'objet fiche
  const SuiviCulturePage({Key? key, required this.fiche}) : super(key: key);

  @override
  _SuiviCulturePageState createState() => _SuiviCulturePageState();
}

class _SuiviCulturePageState extends State<SuiviCulturePage> {
  // Variable pour contrôler la visibilité des informations
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suivi de Culture - ${widget.fiche.nom}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage du nom de la fiche technique et des étapes de culture si visible
            if (_isVisible)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nom de la fiche technique: ${widget.fiche.nom}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Vous devez suivre ces étapes: ${widget.fiche.etapesDeCultureDetail}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Si les informations sont visibles, afficher le bouton "Masquer"
            if (_isVisible)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isVisible = false;  // Masquer les informations
                  });
                },
                child: const Text('Supprimer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),

            // Ajoutez ici le reste du contenu de SuiviCulturePage
          ],
        ),
      ),
    );
  }
}
