import "package:flutter/material.dart";
import '../widgets/auth/login_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: LoginWidget()
    );
  }
}