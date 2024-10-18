// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// // ignore: unused_import
// import 'package:seneso/firebase_options.dart';
// import 'package:seneso/pages/home.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Vérifier si Firebase est déjà initialisé
//   if (Firebase.apps.isEmpty) {
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//         apiKey: 'AIzaSyAhuvhkTuJMUIGDkFjnkxno2D5HQ7DXIFs',
//         appId: '1:906587284024:android:32cc0e545905371f897ccd',
//         messagingSenderId: '906587284024',
//         projectId: 'seneso',
//         storageBucket: 'seneso.appspot.com',
//       ),
//     );
//   } else {
//     print("Firebase déjà initialisé.");
//   }

//   runApp(const MyApp());
// }


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});


//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
    
//     debugShowCheckedModeBanner: false, 
//       home: Home(),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// Importer les options Firebase générées par FlutterFire CLI
import 'package:seneso/firebase_options.dart';
import 'package:seneso/pages/home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Gérer les messages reçus lorsque l'application est en arrière-plan
}


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // ID unique
  'High Importance Notifications', // Nom visible
  description: 'Ce canal est utilisé pour les notifications importantes.',
  importance: Importance.max,
);


void initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Créer le canal pour Android
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Autorisation accordée');
  } else {
    print('Autorisation refusée');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Vérifier si Firebase a déjà été initialisé
  if (Firebase.apps.isEmpty) {
    // Initialiser Firebase avec les options appropriées
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Utilisation des options générées par FlutterFire CLI
    );
  } else {
    print("Firebase déjà initialisé.");
  }

  initializeNotifications();
  requestPermission();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  });



  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
