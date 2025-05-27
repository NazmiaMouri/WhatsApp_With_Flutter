import 'package:flutter/material.dart';
import 'package:whats_app/view/home_screens/home.dart';
import 'package:whats_app/view/login_screens/front_page.dart';
import 'package:whats_app/view/login_screens/language_selection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/view/login_screens/phone_number.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
