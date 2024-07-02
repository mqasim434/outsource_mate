import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class NotificationServices {
  static Future<String> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    return token.toString();
  }

  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "outsource-mate-f4c50",
      "private_key_id": "a6a96761d7e28db3480959259f552d703b93aad9",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDXHW9nXT8iAkq/\nLUhDRnpTSMwGFX+GapLh94Wm+8ntQoET2cp22JrwxwSLtOtJwTaJe0qDokS+SLA3\neM51V/op7QNdoq/jpmqBqox95ky7qIhaJFHzgwd35+6ASi1/7N7Ul9E0HfuEYzTu\nycCWL6vf4X/9pxCOEbBzal7CvJrtbooUybEZkCJxIAVaK5kVhjlg0df8tIDxaUOU\nCDvZmb57zsQlOUYMW8apEd6St6uz8wGhNgcuAnyQs65sHGN7bXnzQMeRkbu+33TJ\nUbypY3rj5gOrHS99dU2jqwu6mv1Etla7ANUjoWaB3T8IzHjEFW6cbfo4KgYRnOAN\no1IelW+tAgMBAAECggEACSTPajeguh+aUUeJuZBanUUsJPsPdWV80l2c4QT1Z6Aq\nz+7zR/t7lI4FH7IkSTmNCamDuJYycVsyIF2CeyLu947DVJzYeKcHgnT/LU/XhaeL\nijdeg2kXrW1eqjXc+sHVE/jTE/HNUeqMorTROqESn3zcnanXDo7qbvF/zyvIsxxq\njWAnwh7w8sS7X6Ig0dG1lQvZJQ8rte0bomb5sPxtAvWs6wFtd/SrPUaYPMmU93JZ\nPsXzr0r/2QneZQCOj6kTHoFaJjl0ERj4oiOrxCQh4f1d+XVzXFqEkydE9AqXYJOU\njwDkVW49ZlRWKyBCEOYSlH3bvTH4ddNhQGcFPrjHqQKBgQDxYXIUsqtU5aUTQhl0\nVXmDBSi8R3EZWAoVisIcw2q24CzcB8dinzWWO7nXR2xWdAEiR4yyWie2FxVx0EI+\nIHOVSMcPhJZVbJaOQwOBrHKyWnIWtoEiIFv77rTs1pUAS58Kiqza6B4u/QuQVyxm\nU3X+ltPpDFcWrgb/YhODmvfWOQKBgQDkJL8BQXNfo///l5mItxZNNIrJsvub4RFK\nzH9XWoszrsaPw1rTJgJDRVx7953JW6skAi5a5KeZX51S7bCx5Abk0cOFOZx3kf0E\n1xmyihReM6UMJbZIPcAeEYPoI1AWRmcS+cTo8wXLSBmRhS1eK8efBVrSPYSIh6V+\nLWi8u5/FFQKBgDIL1i9cbBGKG5PGnKh2IF997lg7J8PtcQnOXzi/e5y3FhX4tupH\nwECJ2Zo9AMVb//AvjYhdEOa8GoIif9mJuO02za71+oVzojOUyWFVc+JuxkDXTibZ\nNrkhYPnJ89K/2xXAct5gSgHMDV279USyAUDr3LvxBw14v5KrrwgWVVRhAoGBANxQ\ngAN+aSQbA8SXabUU2XyFGOHe7guCNWi+QtrgnTyzsxxx0uvE8Lp16PHuFXm2BHcp\nhApSdWcvZoYG83NWeTHPP7kQAYGWgXiDIFXB8hlmViR85qKsvzJKR8+NCnH4WuGA\nQh+TUC0W21oj+cPPE18FlMcikTInjDFlOJfJuGhhAoGBAKnu71+Da6RtF/S3iafU\n+9ltx9gWAnPvvbMoSuP+ddSffdvcNH/vgkqIDIZabb/nLXccKOLcikrXbRiIBkXc\n/Lj+EArwTlePke0P0juvSFEq9p89JOmw9sIqlcd/TgE0gHy9/eWKJMk1rQlIglB4\nyOXaCDb5UYd6ENdYv5OeLUnz\n-----END PRIVATE KEY-----\n",
      "client_email":
          "outsource-mate@outsource-mate-f4c50.iam.gserviceaccount.com",
      "client_id": "117995857496514019342",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/outsource-mate%40outsource-mate-f4c50.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.email',
      'https://www.googleapis.com/auth/firebase.auth',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }

  static sendNotification(String deviceToken, BuildContext context,
      String messageTitle, String messageBody) async {
    final String serverAccessToken = await getAccessToken();
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/outsource-mate-f4c50/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': messageTitle,
          'body': messageBody,
        }
      }
    };

    final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessToken'
        },
        body: jsonEncode(message));

    if (response.statusCode == 200) {
      print('Notification Sent');
    } else {
      print("Failed to send notification");
    }
  }
}
