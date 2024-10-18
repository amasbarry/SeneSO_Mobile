import 'dart:convert'; // Import pour jsonEncode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationService {

  // Fonction pour récupérer un token d'accès depuis Firebase
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      // Authentification sécurisée
      "type": "service_account",
      "project_id": "sosenebrry",
      "private_key_id": "b07a13991d8e2a5fa029b70eafa067c9a7ea8f04",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDWwgGy9OhUjJDq\n4Xgpi/uEYbAljFUljyV7sVQjj13Ytgxxk/+97Maw/WyjM3uYrWPTWuWEbIqWifXe\n2x80vki7fKpOAsxbexPlm1ytXx/1PqKaiMPvPzQlKHhXmh697fWbnh5aygac9QJC\nypW9s8nohb68PG5nUCqsk6JzzPWfJOo9/4ELsH9fFUXtn9TFdJMKGvw5V3wWvwIn\nUC9nq2dvDe3InJCWm12AY9KE8myQB/FY/k+HtJ7/JYptBosPLMAWXRYhcC3P4Uby\nAfXeN2rHuXpAk7NQIFBXKCd4pHd33s9iYZW2jmQrTJbjzqTEgocyHNaxdhYKkCi9\nhdniO9txAgMBAAECggEAGf3lY78wEUTpUywntWuQ7N7qiUODQ1D1ueiROjPjU/5b\nN4cwiCWMj1DqDD8yYcehJyw/TrguS8r1vDEBWrT/ANtf50zVEUCuUfdBj7rNbOAA\nS7tqxLLTFlOKwRt7m1lzWjrDChJHxkkBquDG9Rc57s+lG+DP1zwvdgSblZqu+EGF\nlbyyHT7P/iXvruQ8SVPXlSnuugmGHwjETbLVTrUcoMrmhCry3qGvntuNpdiFc0Ao\nt74j8mxSmvnElfX08dKoCsrgYyBRJf0muShuoFOY+/mfcfWp2wh/E92HhAnfbqhm\nZ3+q128aeBbRgArl+hHin9E038TuW0CBNnPqLW3rKwKBgQDqFBa0yGAS1bIekEnE\nN+7wZ/nQvKn0Evk2Rn4W2X/luOEjtDvBAD3BqSxpl4bqpilyRG42l+YIcVSVwnEB\nf3GGg/xADLB2i+p8QbKtgCYei6lnURBD4gxaBeL9J2FJIigwQtrS+Q5Uy0jF8/Mb\nrqIFBr5iOGELoiRmNHXZEMB5NwKBgQDq3rc2T00ijuicalyduiCXK4z6MXwxn5g5\nVEp3Is3qGlQqabWD9COPNCANqC3hKhqHaRL+TAuvC+RS+jBmukm+s9V9DOOCwUMY\nAniy0BaELPXC+3vjjfROvUOoWAGRHIspSPRW6rrlKJQkSUi8w5+Judo6lUk8baHo\nYnUd2WyElwKBgQDmjLS0iKr/whR2v/y307N2e6J08m2eZVWqHJIyJTUwaQDurqUv\n+fHZnauNsN4EnXYzAq1e/gtmg2EhQ+sT45dIOxUnbJgdmr9wdTDsbEyfR0Wp6hDQ\nG4O44xVn6/KJGqhkqGRo6T8xSyu5NQZcXItd0f+QNCF5WNDrDX6JNlOszwKBgQDX\nmoVzDI8Rd0CfPaAxhkgenXL3xW9tmkTB89e7z65ZBbxXhtyC+h2eesol30nmlaDu\nxw0RdbuQAAmkBlliJAZIUotbFPbQ9BpkMvibpRvWT/N2/ya2OHyZv3IZWlht3lb9\nGiR6mVXhwUNkoAVuiuGsK3jiKGKnXziuu5spQIs2lwKBgQCTZfeetvZPfVneeTDE\n6QwxPCt6hdrHomjFvwcigMAhRM4dN/D6g83AV4xaG9eN6NGHioLF0/LCLqQYWxXG\nNqCnHv3/AZqjcLH1SmtkIK/b6ZIbUeOQh+W79JtsTIWhNNFKxrOyN7gA4l8S4EOM\nm8iGf8ALzAEdNzh/hn7XboEtuQ==\n-----END PRIVATE KEY-----\n",
      "client_email": "sosenebrry@appspot.gserviceaccount.com",
      "client_id": "105684718010965792655",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sosenebrry%40appspot.gserviceaccount.com",
      "universe_domain": "googleapis.com"

    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/userinfo.email'
    ];

    final client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close(); // Fermer le client

    return credentials.accessToken.data;
  }

  // Fonction pour envoyer la notification
  static Future<void> sendNotification({
    required String title,
    required String body,
    required String token,
    required String contextType,
    required String contextData,
  }) async {
    final String serverKey = await getAccessToken();
    final String firebaseMessagingEndpoint = 'https://fcm.googleapis.com/v1/projects/sosenebrry/messages:send';

    final Map<String, dynamic> notificationMessage = {
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'type': contextType,
          'id': contextData,
        },
      }
    };

    // Convertir en chaîne JSON
    final String bodyJson = jsonEncode(notificationMessage);

    // Envoyer la requête POST avec la chaîne JSON dans le corps
    final response = await http.post(
      Uri.parse(firebaseMessagingEndpoint),
      headers: {
        'Authorization': 'Bearer $serverKey',
        'Content-Type': 'application/json',
      },
      body: bodyJson, // Le corps est maintenant au format JSON
    );

    if (response.statusCode == 200) {
      print('Notification envoyée avec succès.');
    } else {
      print('Erreur lors de l\'envoi de la notification : ${response.body}');
    }
  }
}