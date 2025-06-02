import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/constants/colors.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Align(
            child: Text(
          'Edit',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: AppColors.blue),
        )),
        title: Text('Chats'),
        centerTitle: true,
        actions: [
          Icon(
            Icons.edit_note,
            size: 35,
            color: AppColors.blue,
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Broadcast Lists',
                style: TextStyle(color: AppColors.blue),
              ),
              Text(
                'New Group',
                style: TextStyle(color: AppColors.blue),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('opoo'),
                  ),
                  title: Text('popop'),
                  subtitle: Text('Item description'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Handle tap event
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
