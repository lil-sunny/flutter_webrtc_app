import "package:flutter/material.dart";
import "package:webtrc_app/mixins/icon_button_styles_mixin.dart";
import "package:webtrc_app/services/user_service.dart";
import "package:webtrc_app/services/call_service.dart";

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with IconButtonStylesMixin {
      CallService callService = CallService();
  late Future<List<User>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = UserService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          FutureBuilder(
              future: _userList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  List<User> users = snapshot.data as List<User>;

                  return Expanded( // Added Expanded widget
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        User user = users[index];

                        return Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                                color: Color.fromARGB(255, 194, 194, 194)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        "https://pics.craiyon.com/2023-07-16/c37b75fc05724eb19e50836417a51a8f.webp",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        8.0
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        ),
                                        Text(
                                          user.email,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color:
                                                Color.fromARGB(255, 25, 25, 25),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  darkIconButton(
                                    icon: Icons.call,
                                    onPressed: () {
                                      print("call person");
                                      callService.initCall(user);
                                      // SocketService.createVideoConnection(user.id);
                                    },
                                  ),
                                  darkIconButton(
                                    icon: Icons.video_call,
                                    onPressed: () {
                                      print("video call");
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Text('No data available.');
                }
              })
        ]),
      ),
    );
  }
}
