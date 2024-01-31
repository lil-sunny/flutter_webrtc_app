import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  late RTCPeerConnection _peerConnection;

  Future<RTCPeerConnection> createMyPeerConnection() async {
    final Map<String, dynamic> configuration = {
      "iceServers": [
        {"urls": 'stun:stun.l.google.com:19302'}
      ]
    };

    _peerConnection = await createPeerConnection(configuration);

    final Map<String, dynamic> constraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };

    final RTCSessionDescription offer =
        await _peerConnection.createOffer(constraints);
    await _peerConnection.setLocalDescription(offer);

    return _peerConnection;
  }

  void makeCall(RTCPeerConnection peerConnection) async{
    final RTCSessionDescription offer = await peerConnection.createOffer({});
    await peerConnection.setLocalDescription(offer);
  }
}
