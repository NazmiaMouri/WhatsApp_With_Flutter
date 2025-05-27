import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app/constants/colors.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Align(
            child: Text(
          'Edit',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: AppColors.icon),
        )),
        title: Text('Chats'),
        centerTitle: true,
        actions: [
          Icon(
            Icons.edit_note,
            size: 35,
            color: AppColors.icon,
          )
        ],
      ),
    );
  }
}
