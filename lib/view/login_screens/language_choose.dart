import 'package:flutter/material.dart';

class ChooseLang extends StatelessWidget {
  const ChooseLang({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double paddingTop = screenHeight / 8;
    final textGape = paddingTop + (screenHeight / 2.5 / 2);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Padding(
            padding: EdgeInsets.only(top: paddingTop),
            child: Container(
              height: screenHeight / 2.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/WhatsAppBack.png"),
                    scale: 0.5,
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.6),
                      BlendMode.lighten,
                    )),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: screenHeight / 3.5),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.6),
                    Colors.white,
                  ],
                ),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Welcome to WhatsApp',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Choose your language to get started',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
