import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/controllers/call_controller.dart';
import 'package:whats_app/providers/socket_provider.dart';

final callControllerProvider = Provider<CallController>((ref) {
  final socketService = ref.watch(socketServiceProvider);
  final webRTCService = ref.watch(webRTCServiceProvider);

  final callController = CallController(socketService, webRTCService);
  callController.initialize(); // Initialize the controller to set up socket listeners
  return callController;
});