// import "package:flutter_webrtc/flutter_webrtc.dart";
import "package:flutter/material.dart";

class VideoCallingScreen extends StatefulWidget {
  @override
  _VideoCallingScreenState createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  // late RTCPeerConnection _peerConnection;
  // late RTCVideoTrack _localVideoTrack;
  // late RTCVideoTrack _remoteVideoTrack;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // children: [
        //   // Local video
        //   SizedBox(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     // child: RTCVideoView(_localVideoTrack),
        //   ),

        //   // Remote video
        //   Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     alignment: Alignment.center,
        //     // child: RTCVideoView(_remoteVideoTrack),
        //   ),

        //   // Controls
        //   Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: 50,
        //     alignment: Alignment.bottomCenter,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         // Camera button
        //         IconButton(
        //           icon: Icon(Icons.videocam),
        //           onPressed: () {
        //             // Toggle the camera
        //             // _peerConnection.enableVideo(!_peerConnection.isVideoEnabled);
        //           },
        //         ),

        //         // Microphone button
        //         IconButton(
        //           icon: Icon(Icons.mic),
        //           onPressed: () {
        //             // Toggle the microphone
        //             // _peerConnection.enableAudio(!_peerConnection.isAudioEnabled);
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }
}

