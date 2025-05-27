import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/providers/language_provider.dart';

class PhoneNumber extends ConsumerStatefulWidget {
  const PhoneNumber({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends ConsumerState<PhoneNumber> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = 'phone number';
  var _selectedItem;
  late final List<Map<String, String>> countryList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      countryList = ref.watch(countryProvider);
      _selectedItem = countryList[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarBackground,
        automaticallyImplyLeading: false,
        title: Align(
          child: Text(
            'Phone number',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Text('Done'),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Text('Please confirm your country code and'),
          Text('enter your phone number'),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<Map<String, String>>(
                padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                icon: Icon(Icons.chevron_right),
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
            ],
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
    );
  }
}
