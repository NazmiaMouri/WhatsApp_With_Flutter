import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whats_app/services/webrtc_service.dart';

class SocketService {
  late IO.Socket socket;

  SocketService(); 

  void socketConnection() {
    final backendHost =
        'http://192.168.0.218:5000'; // actual localhost for other platforms

    socket = IO.io(backendHost, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    print('Connecting to socket at $backendHost...');
    socket.connect();
    print(socket.connected);
    socket.onConnect((_) {
      print('joining room on connect');

    });
    socket.onConnectError((data) => print('connect error: $data'));
    socket.onError((data) => print('socket error: $data'));
    socket.onDisconnect((reason) => print('disconnected: $reason'));
  }

  void joinCall(String callId) {
    socket.emit('join-call', {
      callId: callId,
    });
  }

  void joinConversation(String message, String type, String conversationId) {
    // setMessage("source", message);
    socket.emit("join-conversation", {
      conversationId: conversationId,
      
    });
  }

  void sendMessage(String message, String type, String conversationId) {
    // setMessage("source", message);
    socket.emit("send-message", {
      conversationId: conversationId,
      "message": message,
      "type": type,
      "time": DateFormat('HH:mm').format(DateTime.now())
    });
  }
}
