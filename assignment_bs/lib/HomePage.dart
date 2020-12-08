import 'package:flutter/material.dart';

import 'constants/Stringconstants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 100,
        backgroundColor: Colors.white,
        title: Text(
          'Flyingwolf',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, color: Colors.black),
          onPressed: () {},
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Image.asset(c_user, height: 80, width: 80), //get from firebase
                Column(
                  children: [
                    Text("Simon Baker"), //get from firebase
                    Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child: Row(
                          children: [
                            Text("2250"),
                            SizedBox(
                              width: 5,
                            ), //change
                            Text("Elo rating") //change
                          ],
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
