import "package:flutter/material.dart";
import "package:flutter_webrtc/flutter_webrtc.dart";
import "package:webtrc_app/services/user_service.dart";
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import "package:http/http.dart" as http;
// import "dart:convert";
import "package:webtrc_app/services/socket_service.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

class CallService {
  static late RTCPeerConnection _peerConnection;
  static Map<String, RTCPeerConnection> peerConnections = {};
  // MediaDevices _mediaDevices = MediaDevices();
  final RTCVideoRenderer _remoteVideoRenderer = RTCVideoRenderer();

  Future<void> initRTCPeerConnectionData(
      RTCPeerConnection peerConnection) async {
    final storage = FlutterSecureStorage();
    final String peerConnectionId = UniqueKey().hashCode.toString();

    print("🍌Peer connection ID: $peerConnectionId");

    peerConnections[peerConnectionId] = peerConnection;
    final Map<String, dynamic> RTCPeerConnectionData = {
      "peerConectionId": peerConnectionId,
      "userId": await storage.read(key: "userId"),
    };
    SocketService.rtcPeerConnection(RTCPeerConnectionData);
  }

  Future<void> initCall(User callee) async {
    final Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"}
      ]
    };

    final storage = FlutterSecureStorage();
    final callerId = await storage.read(key: "userId");

    _peerConnection = await createPeerConnection(configuration, {});

    final offer = await _peerConnection.createOffer({});
    await _peerConnection.setLocalDescription(offer);
    await CallService().initRTCPeerConnectionData(_peerConnection);

    final String calleeId = callee.id.toString();
    final Map<String, dynamic> callData = {
      'type': 'offer',
      'offer': offer.toMap(),
      'calleeId': calleeId,
      'callerId': callerId
    };

    print(callData);

    await _sendCallData(callData);
  }

  Future<void> _sendCallData(Map<String, dynamic> offer) async {
    SocketService.offer(offer);
  }

  Future<void> handleOffer(Map<String, dynamic> offerData) async {
    print("✅handleOffer is started...");
    print("$offerData");

    final Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"}
      ]
    };

    final String? peerConnectionId = offerData['peerConnectionId'] as String?;

    _peerConnection = await createPeerConnection(configuration, {});

    peerConnections[peerConnectionId!] = _peerConnection;

    print("--->$peerConnections");

    final RTCPeerConnection? peerConnection =
        CallService.peerConnections[peerConnectionId];

    if (peerConnection != null) {
      final Map<String, dynamic>? offerMap =
          offerData['offer'] as Map<String, dynamic>?;

      if (offerMap != null &&
          offerMap['sdp'] != null &&
          offerMap['type'] != null) {
        final RTCSessionDescription offer = RTCSessionDescription(
          offerMap['sdp'],
          offerMap['type'],
        );

        await _peerConnection.setRemoteDescription(offer);

        final RTCSessionDescription answer =
            await _peerConnection.createAnswer({});
        await _peerConnection.setLocalDescription(answer);

        final Map<String, dynamic> answerData = {
          'type': 'answer',
          'answer': answer.toMap(),
          'callerId': offerData['callerId'],
        };

        await _sendAnswerData(answerData);
      } else {
        print("Invalid offer data structure");
      }
    } else {
      print("Peer connection null");
    }
  }

  // Ваша функція для відправлення даних відповіді на сервер
  Future<void> _sendAnswerData(Map<String, dynamic> answerData) async {
    SocketService.answer(answerData);
  }

  Future<void> setRemoteDescription(Map<String, dynamic> answerData) async {
    print("✅✅✅✅✅✅setRemoteDescription $answerData");
    final answerSdp = answerData['answer']['sdp'];
    final answerType = answerData['answer']['type'];

    final RTCSessionDescription answer =
        RTCSessionDescription(answerSdp, answerType);

    await _peerConnection.setRemoteDescription(answer);

    await establishCall(answerData);
  }

  Future<void> establishCall(Map<String, dynamic> offerData) async {
    _peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      SocketService.iceCandidate(candidate);
    };
    final localVideoTrack = await navigator.mediaDevices.getUserMedia({
      'video': true,
    });
    final localAudioTrack = await navigator.mediaDevices.getUserMedia({
      'audio': true,
    });
    await _peerConnection.addStream(localVideoTrack);
    await _peerConnection.addStream(localAudioTrack);
    _peerConnection.onAddStream = (stream) {
      _remoteVideoRenderer.srcObject = stream;
    };
  }

  static void test(data) {
    print("✅✅✅Test call service: $data");
  }
}
