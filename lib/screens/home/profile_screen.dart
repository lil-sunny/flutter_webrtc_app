import 'package:flutter/material.dart';
import 'package:webtrc_app/mixins/icon_button_styles_mixin.dart';

class ProfileScreen extends StatelessWidget with IconButtonStylesMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0)),
                    child: ClipOval(
                      child: Image.network(
                          "https://scontent-iev1-1.xx.fbcdn.net/v/t1.6435-9/39821240_532282543867795_4793606968931516416_n.png?stp=dst-png_p526x296&_nc_cat=101&ccb=1-7&_nc_sid=7f8c78&_nc_ohc=WOXJbr4ycrwAX_jOPqp&_nc_ht=scontent-iev1-1.xx&oh=00_AfCUwmF_EUS6eTI-OScNmGqZIsnrQw8QoyHUSbWODzqanA&oe=65AA6106"),
                    )),
                Column(
                  children: [
                    Text(
                      "Namix",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 25, 25, 25)),
                    ),
                    Text(
                      "email@gmail.com",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 25, 25, 25)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    darkIconButton(
                      icon: Icons.call,
                      onPressed: () {
                        print("edit profile");
                      },
                    ),
                    darkIconButton(
                      icon: Icons.video_call,
                      onPressed: () {
                        print("edit profile");
                      },
                    ),
                    darkIconButton(
                      icon: Icons.edit,
                      onPressed: () {
                        print("edit profile");
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
