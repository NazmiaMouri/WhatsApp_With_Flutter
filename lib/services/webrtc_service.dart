import 'dart:io';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class WebRTCService {
  RTCPeerConnection? peerConnection; // webrtc object to establish connection
  MediaStream? localStream, remoteStream; // local and remote media streams

  final io.Socket? socket;
  void Function(MediaStream)? onRemoteStream;

  WebRTCService(this.socket, {this.onRemoteStream});

  Future<void> initialize(String callId) async {
    await initializePeerConnection(callId);
    await initializeLocalMedia();
    await addLocalTracks();
  }

  Future<void> initializePeerConnection(String callId) async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    peerConnection = await createPeerConnection(configuration);

    //generate ice candidates and send them to the signaling server

    peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
     
        socket!.emit('ice-candidate', {
          'callId': callId,
          'candidate': {
            'candidate': candidate.candidate,
            'sdpMid': candidate.sdpMid,
            'sdpMLineIndex': candidate.sdpMLineIndex,
          },
        });
      
    };

    peerConnection!.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        remoteStream = event.streams[0];

        onRemoteStream?.call(remoteStream!);
      }
    };
  }

// get camera and microphone permission and create a local media stream
  Future<void> initializeLocalMedia() async {
    localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });
  }

//adding the tracks to the connection so that it can be sent to the other users
  Future<void> addLocalTracks() async {
    if (localStream == null || peerConnection == null) {
      return;
    }

    for (final track in localStream!.getTracks()) {
      await peerConnection!.addTrack(
        track,
        localStream!,
      );
    }
  }

  Future<void> createOffer(String callId) async {
    if (peerConnection == null) {
      throw SocketException('PeerConnection is not initialized');
    }

    final offer = await peerConnection!.createOffer();
    await peerConnection!
        .setLocalDescription(offer); // setting own description of offer

    // Send the offer to the signaling server
    socket!.emit('offer', {
      'callId': callId,
      'sdp': offer.sdp,
      'type': offer.type,
    });
  }

  Future<void> handleOffer(Map<String, dynamic> data, String callId) async {
    if (peerConnection == null) {
      throw SocketException('PeerConnection is not initialized');
    }

    final offer = RTCSessionDescription(data['sdp'], data['type']);
    await peerConnection!.setRemoteDescription(offer);

    // Create an answer and send it back to the signaling server
    final answer = await peerConnection!.createAnswer();
    await peerConnection!.setLocalDescription(answer);

    socket!.emit('answer', {
      'callId': callId,
      'sdp': answer.sdp,
      'type': answer.type,
    });
  }

  Future<void> handleAnswer(Map<String, dynamic> data) async {
    if (peerConnection == null) {
      throw SocketException('PeerConnection is not initialized');
    }

    final answer = RTCSessionDescription(data['sdp'], data['type']);
    await peerConnection!.setRemoteDescription(answer);
  }

  //get ice candidate and add them
  Future<void> handleIceCandidate(Map<String, dynamic> data) async {
    if (peerConnection == null) {
      throw SocketException('PeerConnection is not initialized');
    }

    final candidate = RTCIceCandidate(
      data['candidate'],
      data['sdpMid'],
      data['sdpMLineIndex'],
    );
    await peerConnection!.addCandidate(candidate);
  }
}
