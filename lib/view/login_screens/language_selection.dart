import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/providers/language_provider.dart';

class LanguageSelection extends ConsumerStatefulWidget {
  const LanguageSelection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LanguageSelectionState();
}

class _LanguageSelectionState extends ConsumerState<LanguageSelection> {
  String selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    // Getting screen width and height

    final screenHeight = MediaQuery.of(context).size.height;
    final double paddingTop = screenHeight / 8;
    final textGape = paddingTop + (screenHeight / 2.5 / 2);
    final languageList = ref.watch(languageProvider);

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
                  Expanded(
                    child: ListView.builder(
                        itemCount: languageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var languageTitle = languageList[index]['name'];
                          var languageName = languageList[index]['subtitle'];
                          print(index);
                          return RadioListTile(
                            title: Text(
                                languageTitle!), // Display the title for option 2
                            subtitle: Text(languageName!),
                            fillColor: MaterialStateColor.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return AppColors
                                    .primary; // fill color when selected
                              }
                              return Colors
                                  .grey; // fill color when not selected
                            }), // Display a subtitle for option 2
                            value: languageList[index]
                                ['name'], // Assign a value of 2 to this option
                            groupValue:
                                selectedLanguage, // Use _selectedValue to track the selected option
                            onChanged: (value) {
                              setState(() {
                                selectedLanguage =
                                    value!; // Update _selectedValue when option 2 is selected
                              });
                            },
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () => {}),
    );
  }
}
