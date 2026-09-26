import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<bool> openUrl(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
        );
      } else {
        // Fallback
        return await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
          webOnlyWindowName: '_blank',
        );
      }
    } catch (e) {
      debugPrint('Error launching URL $urlString: $e');
      return false;
    }
  }

  static Future<bool> openEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': ?subject, 'body': ?body},
    );
    return await openUrl(emailUri.toString());
  }

  static Future<bool> openPhone(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    final Uri telUri = Uri(scheme: 'tel', path: cleanPhone);
    return await openUrl(telUri.toString());
  }

  static Future<bool> downloadResume() async {
    // In Flutter Web, opening the static path serves the PDF directly
    const resumePath = 'manjith_hemachandran_resume.pdf';
    return await openUrl(resumePath);
  }
}
