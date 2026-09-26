import 'package:flutter/material.dart';

class ExperienceModel {
  final String company;
  final String role;
  final String period;
  final String? location;
  final bool isCurrent;
  final List<String> responsibilities;
  final List<String> keyTechnologies;
  final String? highlightSummary;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.period,
    this.location,
    this.isCurrent = false,
    required this.responsibilities,
    required this.keyTechnologies,
    this.highlightSummary,
  });
}

class SkillCategoryModel {
  final String name;
  final IconData icon;
  final List<String> skills;
  final Color accentColor;

  const SkillCategoryModel({
    required this.name,
    required this.icon,
    required this.skills,
    this.accentColor = const Color(0xFF6366F1),
  });
}

class CapabilityModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final String description;
  final List<String> tags;
  final Color accentColor;

  const CapabilityModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.description,
    required this.tags,
    this.accentColor = const Color(0xFF6366F1),
  });
}

class CertificationModel {
  final String title;
  final String issuer;
  final String date;
  final IconData icon;

  const CertificationModel({
    required this.title,
    required this.issuer,
    required this.date,
    this.icon = Icons.verified_outlined,
  });
}

