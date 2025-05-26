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

  final List<Map<String, String>> countries = [
  {
    'name': 'United States',
    'isoAlpha2': 'US',
    'isoAlpha3': 'USA',
    'dialingCode': '+1',
  },
  {
    'name': 'China',
    'isoAlpha2': 'CN',
    'isoAlpha3': 'CHN',
    'dialingCode': '+86',
  },
  {
    'name': 'India',
    'isoAlpha2': 'IN',
    'isoAlpha3': 'IND',
    'dialingCode': '+91',
  },
  {
    'name': 'Germany',
    'isoAlpha2': 'DE',
    'isoAlpha3': 'DEU',
    'dialingCode': '+49',
  },
  {
    'name': 'United Kingdom',
    'isoAlpha2': 'GB',
    'isoAlpha3': 'GBR',
    'dialingCode': '+44',
  },
  {
    'name': 'France',
    'isoAlpha2': 'FR',
    'isoAlpha3': 'FRA',
    'dialingCode': '+33',
  },
  {
    'name': 'Japan',
    'isoAlpha2': 'JP',
    'isoAlpha3': 'JPN',
    'dialingCode': '+81',
  },
  {
    'name': 'Brazil',
    'isoAlpha2': 'BR',
    'isoAlpha3': 'BRA',
    'dialingCode': '+55',
  },
  {
    'name': 'Canada',
    'isoAlpha2': 'CA',
    'isoAlpha3': 'CAN',
    'dialingCode': '+1',
  },
  {
    'name': 'Australia',
    'isoAlpha2': 'AU',
    'isoAlpha3': 'AUS',
    'dialingCode': '+61',
  },
];

  final languageProvider = Provider((_) => languages);

  final countryProvider = Provider((_)=> countries);