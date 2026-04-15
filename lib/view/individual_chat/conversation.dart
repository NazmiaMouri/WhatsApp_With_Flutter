import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/constants/screen_size.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whats_app/models/message_model.dart';
import 'package:whats_app/view/individual_chat/my_message.dart';

class Conversation extends StatefulWidget {
  const Conversation({super.key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  late IO.Socket socket;
  final TextEditingController _textController = TextEditingController();
  List<Message> messages = [];
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
    socketConnection();

    messages = [
      Message(
          type: 'source',
          msg:
              'Hey there! How are you? Hey there! How are you? Hey there! How are you? Hey there! How are you? Hey there! How are you? Hey there! How are you? Hey there! How are you? ',
          time: '11:30',
          status: MessageStatus.seen),
      Message(
          type: 'destination',
          msg: 'I am good, thanks! How about you?',
          time: '11:31'),
      Message(
          type: 'source',
          msg: 'Doing well, just working on a Flutter app.',
          time: '11:32',
          status: MessageStatus.sent),
    ];
  }

  void socketConnection() {
    final backendHost = Platform.isAndroid
        ? 'http://10.0.2.2:5000'
        : 'http://192.168.0.218:5000';

    socket = IO.io(backendHost, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    print('Connecting to socket at $backendHost...');
    socket.connect();
    print(socket.connected);
    socket.onConnect((_) {
      print('connected');
      socket.emit('signin');
      // socket.on('message', (msg) {
      //   print(msg);
      //   setMessage('destination', msg['message']);
      // });
    });
    socket.onConnectError((data) => print('connect error: $data'));
    socket.onError((data) => print('socket error: $data'));
    socket.onDisconnect((reason) => print('disconnected: $reason'));
  }

  void sendMessage(String message, String type) {
    // setMessage("source", message);
    socket.emit("message",
        {"message": message, "type": type, "time": DateFormat('HH:mm').format(DateTime.now())});
  }

  void setMessage(String type, String message) {
    Message messageModel = Message(
        type: type,
        msg: message,
        time: DateTime.now().toString().substring(10, 16),
        status: MessageStatus.sent);
        sendMessage(message,type);
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _textController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.keyboard_backspace)),
        titleSpacing: 0,
        centerTitle: false,
        title: ListTile(
          dense: true,
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'opoo',
            ),
          ),
          title: Text(
            'popop',
            style: TextStyle(fontSize: ScreenSize.width * 0.05),
          ),
          isThreeLine: false,
          onTap: () {
            // Handle tap event
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
                child: Icon(
              Icons.videocam_outlined,
              size: 40,
              color: AppColors.blue,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
                child: Icon(
              Icons.phone_outlined,
              size: 30,
              color: AppColors.blue,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
                child: Icon(
              Icons.more_vert,
              size: 30,
              color: AppColors.blue,
            )),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: ListView.separated(
                    reverse: true,
                    itemCount: messages.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      final isSender =
                          message.type.toLowerCase().contains('source');
                      return ChatBubble(
                        message: message.msg,
                        time: message.time,
                        isSender: isSender,
                        status: message.status,
                      );
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.8),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _textController,
                                decoration: InputDecoration(
                                  hintText: 'Type a message',
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (value) {
                                  if (value.trim().isNotEmpty) {
                                    setMessage('source', value.trim());
                                    _textController.clear();
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.image, color: AppColors.blue),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(_hasText ? Icons.send : Icons.mic,
                            color: Colors.white),
                        onPressed: () {
                          if (_hasText) {
                            final text = _textController.text.trim();
                            setMessage('source', text);
                            _textController.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
