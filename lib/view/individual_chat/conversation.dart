import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
  }

  void socketConnection() {
    socket = IO.io("http://192.168.0.218:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin");
    socket.onConnect((data) {
      socket.on("message", (msg) {
        setMessage("desitation", msg["message"]);
      });
    });
  }

  void sendMessage(String message, int sourceId, int targetId) {
    // setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    Message messageModel = Message(
        type: type,
        msg: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Icon(Icons.chevron_left),
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
          subtitle: Text('tap here for contact info'),
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
          )
        ],
      ),
      body: Stack(children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
          ),
        ),
        MyMessage()
      ]),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.add,
              color: AppColors.blue,
            ),
            SizedBox(
              width: ScreenSize.width / 1.5,
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  hintText: 'Enter text',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.image,
                      size: 30,
                      color: AppColors.blue,
                    ),
                    onPressed: () {
                      // Define the action to perform
                    },
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/Icone=Camera outline.svg',
              semanticsLabel: 'Logo',
              color: AppColors.blue,
              height: 30.0,
              width: 30.0,
            ),
            SvgPicture.asset(
              'assets/icons/Icone=Mic.svg',
              semanticsLabel: 'Logo',
              color: AppColors.blue,
              height: 30.0,
              width: 30.0,
            ),
          ],
        )
      ],
    );
  }
}
