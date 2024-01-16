import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class emailService {
  Future sendEmail(
      {required String name,
      required String email,
      required String subject,
      required String message}) async {
    final serviceId = 'service_4hxkekt';
    final templateId = 'template_u47298i';
    final userId = 'XTTU5mAqyEuVeC-oQ';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message
          }
        }));
  }
}
