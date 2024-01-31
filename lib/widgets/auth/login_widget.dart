import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:another_flushbar/flushbar.dart";
import "package:webtrc_app/services/auth_service.dart";

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  var newUser = new User();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() async {
    newUser.email = emailController.text;
    newUser.password = passwordController.text;

    String result = await AuthService.login(newUser.email, newUser.password);
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
                    offset: Offset(0, 3))
              ],
              color: Colors.white),
          child: Column(
            children: [
              Title(
                  color: Colors.black,
                  child: Text(
                    "Sign In",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  )),
              TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Enter a email")),
              TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Enter a password")),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TextButton(
                    onPressed: _login,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/register');
                },
                child: Text('Sign Up'),
              ),
            ],
          )),
    )));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class User {
  late String email;
  late String password;
}
