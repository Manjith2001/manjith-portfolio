import 'package:flutter/material.dart';
import '../models/experience_model.dart';

class EducationItem {
  final String degree;
  final String institution;
  final String date;
  final String location;

  const EducationItem({
    required this.degree,
    required this.institution,
    required this.date,
    required this.location,
  });
}

class EducationData {
  static const List<EducationItem> educationList = [
    EducationItem(
      degree: 'B.Tech in Computer Science',
      institution: 'Lourdes Matha College of Science and Technology',
      date: 'Jan 2023',
      location: 'Kerala, India',
    ),
    EducationItem(
      degree: 'Higher Secondary',
      institution: "St Mary's HSS, TVM Pattom",
      date: 'Jan 2019',
      location: 'Thiruvananthapuram, Kerala',
    ),
  ];

  static const List<CertificationModel> certifications = [
    CertificationModel(
      title: 'AI Tools & Claude Workshop',
      issuer: 'be10x',
      date: 'September 20, 2026',
      icon: Icons.psychology_outlined,
    ),
    CertificationModel(
      title: 'Full Stack Website Development in Java/React',
      issuer: 'MashupStack',
      date: 'Certified',
      icon: Icons.code_rounded,
    ),
    CertificationModel(
      title: 'Ethical Hacking Internship',
      issuer: 'Industry Program',
      date: 'Certified',
      icon: Icons.security_rounded,
    ),
    CertificationModel(
      title: 'Advanced Fuel Injection on System with BOSCH',
      issuer: 'SKYY',
      date: '11/01/2020',
      icon: Icons.precision_manufacturing_rounded,
    ),
    CertificationModel(
      title: 'Scientific Computing with Python',
      issuer: 'Industry Certification',
      date: '07/01/2021',
      icon: Icons.terminal_rounded,
    ),
    CertificationModel(
      title: 'Python 3.4.3 Training',
      issuer: 'Spoken Tutorial, Project at IIT Bombay',
      date: '06/01/2021',
      icon: Icons.school_outlined,
    ),
    CertificationModel(
      title: 'SCRUM Master Certification',
      issuer: 'Udemy',
      date: '2020',
      icon: Icons.groups_outlined,
    ),
  ];
}

