import 'dart:convert';
import 'package:http/http.dart' as http;

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
}

//   static Future<void> sendEmail(
//       String body, String subject, String receipentEmail) async {
//     final Email email = Email(
//       body: body,
//       subject: subject,
//       recipients: [receipentEmail],
//       isHTML: false,
//     );
//     await FlutterEmailSender.send(email);
//   }
// }
