import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/services/socket_service.dart';
import 'package:whats_app/services/webrtc_service.dart';

final socketServiceProvider=Provider<SocketService>((ref) {
  final socketService = SocketService();
  
  socketService.socketConnection();

  ref.onDispose(() {
    socketService.socket.dispose();
  });

  return socketService;
});


final webRTCServiceProvider = Provider<WebRTCService>((ref) {

  final socketService = ref.watch(socketServiceProvider);
  return WebRTCService(socketService.socket);
});