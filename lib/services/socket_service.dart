import 'package:socket_io_client/socket_io_client.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
// import "package:fluttertoast/fluttertoast.dart";
// import "package:flutter/material.dart";
import "package:flutter_webrtc/flutter_webrtc.dart";

class SocketService {
  static Socket? _socket;

  Future<String?> getUserId() async {
    final storage = FlutterSecureStorage();
    final userId = await storage.read(key: "userId");

    if (userId != null) {
      print(userId);
      return userId.toString();
    }
    return null;
  }

  static Future<Socket> initSocket() async {
    final userId = await SocketService().getUserId();

    print("Creating a new socket instance");
    _socket = io("http://localhost:3002", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userId': '$userId'}
    });

    SocketService().authenticateSocket();

    return _socket!;
  }

  Future<void> authenticateSocket() async {
    print("Function work - authenticateSocket");
    final userId = await SocketService().getUserId();
    _socket?.emit("authenticate", userId);
  }

  static Future<Socket> get socket async {
    if (_socket == null) {
      await initSocket();
    } else {
      print("Using existing socket instance");
    }
    return _socket!;
  }

  static Socket? get connectedSocket {
    if (_socket?.connected ?? false) {
      return _socket;
    }
    return null;
  }

  static void connect() {
    try {
      print("Connecting to the socket from service");
      _socket?.connect();
    } catch (e) {
      print("Error connecting to the socket: $e");
    }
  }

  static void disconnect() {
    _socket?.disconnect();
  }

  static void offer(data) {
    print("From service: $data");
    if (_socket?.connected ?? false) {
      _socket?.emit("offer", data);
    } else {
      print("Socket is not connected. Cannot emit offer.");
    }
  }

  static void answer(Map<String, dynamic> answerData) {
    _socket?.emit("answer", answerData);
  }

  static void rtcPeerConnection(Map<String, dynamic> rtcPeerConnectionData) {
    _socket?.emit("RTCPeerConnection", rtcPeerConnectionData);
  }

  static void iceCandidate(RTCIceCandidate candidate) {
    // Emit the ICE candidate to the signaling server
    _socket?.emit('iceCandidate', {
      'candidate': candidate.toMap(),
      // 'peerConnectionId':  peerConnctionId, // Add peerConnectionId if needed
    });
  }
}
