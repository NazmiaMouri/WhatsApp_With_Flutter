import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/l10n/app_localizations.dart';
import 'package:whats_app/providers/language_provider.dart';
import 'package:country_codes/country_codes.dart';

class PhoneNumber extends ConsumerStatefulWidget {
  const PhoneNumber({super.key});

  @override
  ConsumerState<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends ConsumerState<PhoneNumber> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  String _displayText = 'phone number';
  var _selectedItem;
  late final List<Map<String, String>> countryList;
  bool _isLoadingCountry = true;

  @override
  void initState() {
    super.initState();
    _initializeCountrySelection();
  }

  Future<void> _initializeCountrySelection() async {
    await CountryCodes.init();
    final list = ref.read(countryProvider);
    final Locale? deviceLocale = CountryCodes.getDeviceLocale();

    final selected = list.firstWhere(
      (element) => element['isoAlpha2'] == deviceLocale?.countryCode,
      orElse: () => list[0],
    );

    if (!mounted) return;

    setState(() {
      countryList = list;
      _selectedItem = selected;
      _isLoadingCountry = false;
    });

    _phoneFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingCountry) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appbarBackground,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(
                  Icons.more_vert,
                ),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(
               AppLocalizations.of(context)!.enteryourphonenumber,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.verifyPhoneNumber,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
                children: [
                  const TextSpan(
                    text: 'Carrier charges may apply. ',
                  ),
                  TextSpan(
                      text: 'What\'s my number?',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<Map<String, String>>(
              icon: Icon(Icons.arrow_drop_down),
              value: _selectedItem,
              selectedItemBuilder: (BuildContext context) {
                return countryList.map<Widget>((Map<String, String> item) {
                  return Row(
                    children: [
                      Text(item['name']!),
                      SizedBox(
                          width: MediaQuery.of(context).size.width /
                              1.8), // Adjusts spacing between text and icon
                    ],
                  );
                }).toList();
              },
              items: countryList.map((Map<String, String> item) {
                return DropdownMenuItem<Map<String, String>>(
                  value: item,
                  child: Text(item['name']!),
                );
              }).toList(),
              onChanged: (Map<String, String>? newValue) {
                setState(() {
                  _selectedItem = newValue!;
                });
              },
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Text(_selectedItem['dialingCode']),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: _phoneFocusNode,
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'phone number',
                          hintStyle: TextStyle(color: Colors.grey)),
                      onChanged: (text) {
                        setState(() {
                          _displayText = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
        bottomNavigationBar: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _displayText.isEmpty
                  ? Colors.grey
                  : AppColors.primary, // Change color based on input
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: Text(
              'Next',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: _displayText.isEmpty
                ? null
                : () => {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    )),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Verified',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                        'Your number has been securely verified on this device.'),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                     Navigator.pushNamed(context, '/home');
                                  },
                                  child: const Text('Continue'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    }));
  }
}
