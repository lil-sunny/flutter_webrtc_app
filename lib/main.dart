import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import "screens/video_calling_screen.dart";
import "screens/home1_screen.dart";
// import "screens/home/chat_screen.dart";
// import "screens/home/chats_screen.dart";
// import "screens/home/friends_screen.dart";
// import "screens/home/search_screen.dart";
void main() {
  runApp(MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (ctx, state) => HomeScreen()),
    GoRoute(path: "/home", builder: (ctx, state) => Home1Screen()),
    GoRoute(path: "/login", builder: (ctx, state) => LoginScreen()),
    GoRoute(path: "/register", builder: (ctx, state) => RegisterScreen()),
    GoRoute(path: "/calling", builder: (ctx, state) => VideoCallingScreen()),
    // GoRoute(path: "/chats", builder: (ctx, state) => ChatsScreen()),
    // GoRoute(path: "/people", builder: (ctx, state) => PeopleScreen()),
    // GoRoute(path: "/search", builder: (ctx, state) => SearchScreen()),
    // GoRoute(path: "/friends", builder: (ctx, state) => FriendsScreen()),
  ]
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}