import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:whats_app/providers/call_controller_provider.dart';
import 'package:whats_app/providers/socket_provider.dart';
import 'package:whats_app/services/webrtc_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoCall extends ConsumerStatefulWidget {
  final String callId;
  const VideoCall({super.key, required this.callId});

  @override
  ConsumerState<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends ConsumerState<VideoCall> {
  double _localVideoRight = 16;
  double _localVideoBottom = 100;

  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  late final WebRTCService webRTCService;
  late final callController;

  @override
  void initState() async {
    super.initState();
    //get webrtc service from river pod
    webRTCService = ref.read(webRTCServiceProvider);
    callController = ref.read(callControllerProvider);
    // initializing the renderers
    _initializeRenderer();
    //display remote stream when it is available
    webRTCService.onRemoteStream = (stream) {
      _remoteRenderer.srcObject = stream;
    };
    //start the call
    await callController.startCall(widget.callId);
    // Display local stream
    if (webRTCService.localStream != null) {
      _localRenderer.srcObject = webRTCService.localStream;
    }
  }

  Future<void> _initializeRenderer() async {
    await _remoteRenderer.initialize();
    await _localRenderer.initialize();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // ---------------------------------------------------
            // Remote Video Full screen
            // ---------------------------------------------------
            Positioned.fill(
              child: RTCVideoView(
                _remoteRenderer,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              ),
            ),
            //------------------------------------------------------
            // Local Video small screen
            //------------------------------------------------------
            Positioned(
              right: _localVideoRight,
              bottom: _localVideoBottom,
              width: 120,
              height: 160,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _localVideoRight -= details.delta.dx;
                    _localVideoBottom -= details.delta.dy;
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: RTCVideoView(
                    _localRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
