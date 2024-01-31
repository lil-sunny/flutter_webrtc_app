import "package:flutter/material.dart";
import '../widgets/auth/register_widget.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: RegisterWidget()
    );
  }
}