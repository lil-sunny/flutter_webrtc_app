// import "dart:html";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:another_flushbar/flushbar.dart";
import "package:webtrc_app/services/auth_service.dart";

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  var newUser = new User();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  void _register() async {
    newUser.name = nameController.text;
    newUser.email = emailController.text;
    newUser.password = passwordController.text;
    var rePassword = rePasswordController.text;

    print('Name: ${newUser.name}');
    print('Email: ${newUser.email}');
    print('Password: ${newUser.password}');

    if (newUser.password == rePassword) {
      String result = await AuthService.register(newUser.name, newUser.email, newUser.password);
      print('Result $result');
      if (result == "") {
        context.go("/home");
      }
      else {
        Flushbar(
          title: 'Error',
          message: '${result}',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } else {
      Flushbar(
          title: 'Error:',
          message: 'Passwords do not match',
          duration: Duration(seconds: 3),
        )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 320,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                Title(
                  color: Colors.black,
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter your name",
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter a email",
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter a password",
                  ),
                ),
                TextFormField(
                  controller: rePasswordController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter a password",
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: TextButton(
                    onPressed: _register,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go("/login");
                  },
                  child: Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
}

class User {
  late String name;
  late String email;
  late String password;
}
