import 'dart:convert';

import 'package:http/http.dart' as http;

class ContactSubmission {
  final String name;
  final String email;
  final String category;
  final String message;

  const ContactSubmission({
    required this.name,
    required this.email,
    required this.category,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'category': category,
    'message': message,
    '_subject': 'Portfolio Inquiry from $name ($category)',
    '_replyto': email,
    '_template': 'table',
  };
}

class ContactResult {
  final bool isSuccess;
  final String message;
  final bool useMailtoFallback;

  const ContactResult({
    required this.isSuccess,
    required this.message,
    this.useMailtoFallback = false,
  });
}

class ContactService {
  static const String _endpoint =
      'https://formsubmit.co/ajax/manjithhemachandran333@gmail.com';

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  static Future<ContactResult> submitInquiry(
    ContactSubmission submission,
  ) async {
    // 1. Client-side field validations
    if (submission.name.trim().isEmpty) {
      return const ContactResult(
        isSuccess: false,
        message: 'Please provide your name or organization.',
      );
    }

    if (!isValidEmail(submission.email)) {
      return const ContactResult(
        isSuccess: false,
        message: 'Please provide a valid email address (e.g. name@domain.com).',
      );
    }

    if (submission.message.trim().length < 5) {
      return const ContactResult(
        isSuccess: false,
        message: 'Please provide a brief message of at least 5 characters.',
      );
    }

    // 2. Dispatch via FormSubmit endpoint to manjithhemachandran333@gmail.com
    try {
      final response = await http
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(submission.toJson()),
          )
          .timeout(const Duration(seconds: 12));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return const ContactResult(
          isSuccess: true,
          message: 'Your inquiry has been sent directly to Manjith\'s email inbox. You will receive a response shortly!',
        );
      } else {
        return ContactResult(
          isSuccess: false,
          useMailtoFallback: true,
          message:
              'Direct submission encountered a status ${response.statusCode}. You can send directly via your mail client.',
        );
      }
    } catch (e) {
      // Offline, network timeout, or CORS block fallback
      return const ContactResult(
        isSuccess: false,
        useMailtoFallback: true,
        message: 'Unable to reach email service. Click "Send via Email App" below to open in your mail client.',
      );
    }
  }
}
