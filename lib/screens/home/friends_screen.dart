import "package:flutter/material.dart";

class FriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Friends')),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            // Your content goes here
            // ...
            // Example content
            ListTile(title: Text('Friend 1')),
            ListTile(title: Text('Friend 2')),
            // Add more items as needed
          ],
        ),
      ),
    );
  }
}
