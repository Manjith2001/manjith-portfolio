import 'package:flutter/material.dart';

class ProjectModel {
  final String id;
  final String name;
  final String category;
  final String shortDescription;
  final String fullDescription;
  final String role;
  final List<String> technologies;
  final List<String> features;
  final List<String> integrations;
  final List<String> platforms;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? websiteUrl;
  final List<String> screenshots;
  final String? videoAsset;
  final String? clientName;
  final String? clientRegion;
  final List<String> paymentGateways;
  final bool hasMapIntegration;
  final bool hasShorebirdOta;
  final bool isFeatured;
  final Color accentColor;

  const ProjectModel({
    required this.id,
    required this.name,
    required this.category,
    required this.shortDescription,
    required this.fullDescription,
    required this.role,
    required this.technologies,
    required this.features,
    required this.integrations,
    required this.platforms,
    this.playStoreUrl,
    this.appStoreUrl,
    this.websiteUrl,
    required this.screenshots,
    this.videoAsset,
    this.clientName,
    this.clientRegion,
    this.paymentGateways = const [],
    this.hasMapIntegration = false,
    this.hasShorebirdOta = false,
    this.isFeatured = false,
    this.accentColor = const Color(0xFF6366F1),
  });

  bool get hasPlayStore => playStoreUrl != null && playStoreUrl!.isNotEmpty;
  bool get hasAppStore => appStoreUrl != null && appStoreUrl!.isNotEmpty;
  bool get hasScreenshots => screenshots.isNotEmpty;
  bool get hasVideo => videoAsset != null && videoAsset!.isNotEmpty;
  String get thumbnail => screenshots.isNotEmpty ? screenshots.first : '';
  bool get hasPayments => paymentGateways.isNotEmpty;
}
