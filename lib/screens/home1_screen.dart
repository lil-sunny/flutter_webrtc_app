import "package:flutter/material.dart";
import "package:socket_io_client/socket_io_client.dart" as io;
import "package:webtrc_app/services/call_service.dart";
import "../mixins/icon_button_styles_mixin.dart";
import "package:webtrc_app/services/socket_service.dart";
// import "package:fluttertoast/fluttertoast.dart";

import "./home/chats_screen.dart";
import "./home/profile_screen.dart";
import "./home/friends_screen.dart";
import "./home/search_screen.dart";

class Home1Screen extends StatefulWidget with IconButtonStylesMixin {
  @override
  _Home1ScreenState createState() => _Home1ScreenState();
}

class _Home1ScreenState extends State<Home1Screen> {
  PageController _pageController = PageController(initialPage: 0);
  late io.Socket socket;
  bool isCallDialogOpen = false;
  late var dataFromOffer;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  Future<bool?> showCallDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Вхідний виклик"),
          content: Text("Вас викликають, бажаєте прийняти дзвінок?"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                await CallService().handleOffer(dataFromOffer);
              },
              child: Text("Прийняти", style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Відхилити", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> initSocket() async {
    socket = await SocketService.socket;
    socket.on("connect", (_) {
      print("Connected by socket");
    });

    socket.on("disconnect", (_) {
      print("Disconnected by socket");
    });

    socket.on("offer", (data) async {
      dataFromOffer = data;

      bool? isCallAccepted;

      if (!isCallDialogOpen) {
        isCallDialogOpen = true;
        isCallAccepted = await showCallDialog();
      }

      if (isCallAccepted != null && isCallAccepted) {
        isCallDialogOpen =
            false; // Закрываем диалоговое окно после принятия вызова
      } else {
        print("❌Reject a call");
      }
    });

    socket.on("setRemoteDescription", (data) async {
      print("setRemoteDescription work");
      await CallService().setRemoteDescription(data);
    });

    socket.connect();
  }

  @override
  void dispose() {
    _pageController.dispose();
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  ProfileScreen(),
                  SearchScreen(),
                  FriendsScreen(),
                  ChatsScreen(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 173, 173, 173)),
                borderRadius: BorderRadius.circular(0.0),
                color: Color.fromARGB(214, 25, 25, 25),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.lightIconButton(
                      icon: Icons.person,
                      onPressed: () {
                        print("show profile");
                        _pageController.jumpToPage(0);
                      },
                    ),
                    widget.lightIconButton(
                      icon: Icons.search,
                      onPressed: () {
                        print("search people");
                        _pageController.jumpToPage(1);
                      },
                    ),
                    widget.lightIconButton(
                      icon: Icons.people,
                      onPressed: () {
                        print("show friends");
                        _pageController.jumpToPage(2);
                      },
                    ),
                    widget.lightIconButton(
                      icon: Icons.chat_sharp,
                      onPressed: () {
                        print("show chats");
                        _pageController.jumpToPage(3);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
