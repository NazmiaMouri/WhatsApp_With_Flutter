import 'package:whats_app/services/socket_service.dart';
import 'package:whats_app/services/webrtc_service.dart';

class CallController {
  final SocketService socketService;
  final WebRTCService webRTCService;

  CallController(
    this.socketService,
    this.webRTCService,
  );

  void initialize() {
    final socket = socketService.socket;

    socket.on('incoming-call', (data) {
      print('Incoming call: $data');
      // Handle incoming call logic here
    });

    socket.on('user-joined-call', (data) async {
      print('User joined-call: $data[socket.id]');
      await webRTCService
          .createOffer(data['callId']); // passing the callId to createOffer
    });

    socket.on('offer', (data) async {
      print('Received offer: $data');
      await webRTCService.handleOffer(
          data, data['callId']); // passing the callId to handleOffer
    });

    socket.on('answer', (data) async {
      print('Received answer: $data');
      await webRTCService
          .handleAnswer(data); // passing the callId to handleAnswer
    });

    socket.on('ice-candidate', (data) async {
      print('Received ICE candidate: $data');
      await webRTCService.handleIceCandidate(Map<String, dynamic>.from(
          data)); // passing the callId to handleIceCandidate
    });
  }

  void initiateCall(
      {required String receiverId,
      required String callId,
      required String callType}) {
    socketService.startCall(
        receiverId: receiverId, callId: callId, callType: callType);
  }

  Future<void> startCall(String callId) async {
    await webRTCService.initialize(callId);
    socketService.joinCall(callId);
  }
}
