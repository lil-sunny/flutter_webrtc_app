import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
// import "package:socket_io_client/socket_io_client.dart" as io;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late io.Socket socket;

  @override
  void initState() {
    super.initState();

    // socket = io.io("http://localhost:3002", <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    // });

    // socket.on("connect", (_) {
    //   print("Connected by socket");
    // });

    // socket.on("disconnect", (_) {
    //   print("Disconnected by socket");
    // });

    // socket.connect();
  }

  @override
  void dispose() {
    // socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Row(
      children: [
        Column(
          children: [
            IconButton(
                onPressed: () => print("Show peoples"),
                icon: Icon(Icons.people)),
            IconButton(
                onPressed: () => print("Show peoples"),
                icon: Icon(Icons.people)),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/register');
          },
          child: Text('Sign Up'),
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/login');
          },
          child: Text('Sign In'),
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/calling');
          },
          child: Text('Video Calling'),
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/home');
          },
          child: Text('Go to Home 1'),
        ),
      ],
    ));
  }
}
