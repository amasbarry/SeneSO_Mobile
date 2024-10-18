// import 'package:flutter/material.dart';

// class InscriptionPage extends StatefulWidget {
//   @override
//   _InscriptionPageState createState() => _InscriptionPageState();
// }

// class _InscriptionPageState extends State<InscriptionPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _nom = '';
//   String _prenom = '';
//   String _email = '';
//   String _password = '';
//   String _typeExploitation = '';
//   List<String> _culturesPrincipales = [];
//   String _region = '';

//   void _creerUtilisateur() {
//     if (_formKey.currentState!.validate()) {
//       // Logique pour créer l'utilisateur
//       // Par exemple : Appel à votre service d'utilisateur
//       // Vous pourriez aussi gérer le retour ici (naviguer vers la page de connexion)
//       Navigator.pop(context); // Retourne à la page de connexion après l'inscription
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Inscription')),
//       body: Stack(
//         children: [
//           // Image d'arrière-plan
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/bg2.png'), // Image de fond
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Dégradé transparent au-dessus de l'image
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.green.withOpacity(0.7),
//                   Colors.green.withOpacity(0.4),
//                 ],
//               ),
//             ),
//           ),
//           // Contenu principal de la page
//           Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 10,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Inscription',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Nom',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => _nom = value ?? '',
//                         validator: (value) => value!.isEmpty ? 'Entrez votre nom' : null,
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Prénom',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => _prenom = value ?? '',
//                         validator: (value) => value!.isEmpty ? 'Entrez votre prénom' : null,
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => _email = value ?? '',
//                         validator: (value) => !RegExp(r'\S+@\S+\.\S+').hasMatch(value!)
//                             ? 'Entrez un email valide'
//                             : null,
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Mot de passe',
                          
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => _password = value ?? '',
//                         validator: (value) => value!.length < 6
//                             ? 'Le mot de passe doit contenir au moins 6 caractères'
//                             : null,
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Type d’exploitation',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => _typeExploitation = value ?? '',
//                         validator: (value) => value!.isEmpty ? 'Entrez le type d’exploitation' : null,
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Cultures principales (séparées par des virgules)',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) {
//                           if (value != null) {
//                             _culturesPrincipales = value.split(',').map((e) => e.trim()).toList();
//                           }
//                         },
//                         validator: (value) => value!.isEmpty ? 'Entrez les cultures principales' : null,
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Région',
//                           border: OutlineInputBorder(),
//                         ),
//                         onSaved: (value) => _region = value ?? '',
//                         validator: (value) => value!.isEmpty ? 'Entrez votre région' : null,
//                       ),
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           onPressed: () {
//                             _creerUtilisateur();
//                           },
//                           child: const Text(
//                             'S’inscrire',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }








import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _nom = '';
  String _prenom = '';
  String _email = '';
  String _motDePasse = '';
  String _typeExploitation = '';
  String _culturesPrincipales = '';
  String _region = '';
  String _role = 'Agriculteur';

  // Fonction de création d'utilisateur
  void _creerUtilisateur() async {
    if (_formKey.currentState!.validate()) {
      print("Validation réussie. Tentative de création d'un utilisateur...");

      try {
        // Créer l'utilisateur avec FirebaseAuth
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _motDePasse, // Utilisation de motDePasse ici
        );

        print("Utilisateur créé avec succès avec l'email : $_email");

        // Récupérer l'ID de l'utilisateur
        String uid = userCredential.user!.uid;
        print("UID de l'utilisateur : $uid");

        // Ajouter l'utilisateur dans la collection "users" de Firestore
        await _firestore.collection('users').doc(uid).set({
          'nom': _nom,
          'prenom': _prenom,
          'email': _email,
          'typeExploitation': _typeExploitation,
          'culturesPrincipales': _culturesPrincipales,
          'region': _region,
          'role': _role,
          'uid': uid,
        });

        print("Utilisateur ajouté à Firestore avec l'UID : $uid");

        // Retourner à la page précédente après l'inscription
        Navigator.pop(context);
      } catch (e) {
        print("Erreur lors de la création de l'utilisateur : $e");

        // Afficher une erreur si l'inscription échoue
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom'),
                onChanged: (value) {
                  setState(() {
                    _nom = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prénom'),
                onChanged: (value) {
                  setState(() {
                    _prenom = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _motDePasse = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Type d\'exploitation'),
                onChanged: (value) {
                  setState(() {
                    _typeExploitation = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le type d\'exploitation';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cultures principales'),
                onChanged: (value) {
                  setState(() {
                    _culturesPrincipales = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer les cultures principales';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Région'),
                onChanged: (value) {
                  setState(() {
                    _region = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la région';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _creerUtilisateur,
                child: const Text('Créer un compte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




