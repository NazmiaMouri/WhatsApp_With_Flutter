import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallList extends ConsumerStatefulWidget {
  const CallList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallListState();
}

class _CallListState extends ConsumerState<CallList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calls',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          Icon(
            Icons.search,
            size: 35,
          ),
          Icon(
            Icons.more_vert_outlined,
            size: 35,
          )
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.blue,
                    ),
                    child: Icon(Icons.call, color: Colors.white),
                  ),
                  Text('Call')
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.blue,
                    ),
                    child: Icon(Icons.schedule, color: Colors.white),
                  ),
                  Text('Schedule')
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.blue,
                    ),
                    child: Icon(Icons.keyboard_backspace_rounded,
                        color: Colors.white),
                  ),
                  Text('Keypad')
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.blue,
                    ),
                    child: Icon(Icons.favorite_outline_rounded,
                        color: Colors.white),
                  ),
                  Text('Favorites')
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Text('Recent',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10, // Example item count
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
                ),
                title: Text('Contact ${index + 1}'),
                subtitle: Row(
                  children: [
                    Icon(Icons.call_made, size: 16, color: Colors.green),
                    SizedBox(width: 4),
                    Text('Yesterday, 5:00 PM'),
                  ],
                ),
                trailing: Icon(Icons.call),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: Icon(
          Icons.call_end,
        ),
      ),
    );
  }
}
