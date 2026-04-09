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
        title: Text(
          'WhatsApp',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          Icon(
            Icons.camera_alt_outlined,
            size: 35,
          ),
          Icon(
            Icons.more_vert_outlined,
            size: 35,
          ),
         
        ],
      ),  
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Ask Meta AI or Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onChanged: (value) {
              print(value); // handle search logic
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Archived'),
            leading: Icon(Icons.system_update_alt),
            trailing: Text('1'),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('opoo'),
                  ),
                  title: Text('popop'),
                  subtitle: Text('Item description'),
                  trailing: Column(
                    children: [
                      Text('23/7/2026'),
                      Icon(Icons.notifications_off)
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/individualChat');

                    // Handle tap event
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: Icon(
          Icons.add_comment_rounded,
        ),
      ),
    );
  }
}
