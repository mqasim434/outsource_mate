import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static Future<void> sendSignupEmail(
    String name,
    String email,
  ) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'https://localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'service_id': 'service_4848gyc',
          'template_id': 'template_58vu0ab',
          'user_id': 'zJSN6DD2UCW_uzI8A',
          'template_params': {
            'to_name': name,
            'to_email': email,
          },
        },
      ),
    );
  }

  static Future<void> sendMail(
      { required String receipentMail,required String subject,required String mailMessage}) async {
    String username = 'outsourcemate41@gmail.com';
    String password = 'bmfl twnq oksp hizi';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = const Address('outsourcemate41@gmail.com')
      ..recipients.add(receipentMail)
      ..subject = subject
      ..text = mailMessage;

    try {
      await send(message, smtpServer);
      print('EMail Send successfully');
    } catch (e) {
      print(e);
    }
  }
}
