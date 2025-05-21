 import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<Map<String, String>> languages = [
    {'name': 'English', 'subtitle': "(phone's language)"},
    {'name': 'हिन्दी', 'subtitle': 'Hindi'},
    {'name': 'मराठी', 'subtitle': 'Marathi'},
    {'name': 'ગુજરાતી', 'subtitle': 'Gujarati'},
    {'name': 'தமிழ்', 'subtitle': 'Tamil'},
    {'name': 'বাংলা', 'subtitle': 'Bengali'},
    {'name': 'తెలుగు', 'subtitle': 'Telugu'},
    {'name': 'ಕನ್ನಡ', 'subtitle': 'Kannada'},
  ];

  final languageProvider = Provider((_) => languages);