import 'package:assignment_bs/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'ReusableListTile.dart';
import 'constants/Stringconstants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _tournamentsList = [];
  Map<String, dynamic> _userInfo = {};
  String _cursor;

  @override
  initState() {
    super.initState();

    _fetchUserInfo().then((value) {
      _fetchInitialTournaments();
    });
  }

  _fetchUserInfo() async {
    var userInfoDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc("mtjJTpAbyU3ldfb7jKU1")
        .get();

    _userInfo = userInfoDoc.data();
    setState(() {});
  }

  _fetchInitialTournaments() async {
    String apiUrl =
        'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all';

    http.get(apiUrl).then((result) {
      var jsonResponse = convert.jsonDecode(result.body);
      _tournamentsList = jsonResponse["data"]["tournaments"];

      _cursor = jsonResponse["data"]["cursor"];

      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: Center(
          child: Text(
            'Flyingwolf',
            style: TextStyle(color: Colors.black),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (_) => false);
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: _userInfo.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(c_user, height: 90, width: 80),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 0.0),
                            child: Text(
                              _userInfo["name"],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.all(15.0),
                              padding:
                                  const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Row(
                                  children: [
                                    Text(
                                      _userInfo["elorating"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.blue[800]),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Elo rating"),
                                    SizedBox(width: 10)
                                  ],
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [
                                0.6,
                                1
                              ],
                              colors: [
                                Colors.orange,
                                Colors.orange.withOpacity(0.6),
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              Text(_userInfo["tplayed"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("Tournaments \n played",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 1),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [
                              0.5,
                              1
                            ],
                            colors: [
                              Colors.deepPurple,
                              Colors.deepPurple.withOpacity(0.75),
                            ]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Text(_userInfo["twon"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text("Tournaments \n won",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 1),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(18),
                        bottomRight: const Radius.circular(18),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.deepOrange,
                                Colors.deepOrange.withOpacity(0.65),
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              Text(_userInfo["winpercentage"] + "%",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("Winning \n percentage",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Recommended for you",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _tournamentsList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == _tournamentsList.length) {
                            if (index != 0) {
                              _fetchMoreTournaments();
                            }
                            return Center(child: CircularProgressIndicator());
                          }

                          var curTournament = _tournamentsList[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: ReusableListTile(
                                curTournament["game_name"],
                                curTournament["cover_url"],
                                curTournament["name"]),
                          );
                        }),
                  )
                ],
              ),
            ),
    ));
  }

  _fetchMoreTournaments() async {
    String apiUrl =
        'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=$_cursor';

    var result = await http.get(apiUrl);
    var jsonResponse = convert.jsonDecode(result.body);
    _cursor = jsonResponse["data"]["cursor"];
    _tournamentsList += jsonResponse["data"]["tournaments"];
    setState(() {});
  }
}
