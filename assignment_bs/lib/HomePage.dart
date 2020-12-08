import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'ReusableListTile.dart';
import 'constants/Stringconstants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _tournamentsList = [];
  String _cursor;

  @override
  initState() {
    super.initState();
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
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 100,
        backgroundColor: Colors.white70,
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(c_user, height: 80, width: 80), //get from firebase
                Column(
                  children: [
                    Text("Simoni Baker"), //get from firebase
                    Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Row(
                            children: [
                              Text(
                                "2250",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800]),
                              ),
                              SizedBox(
                                width: 5,
                              ), //change
                              Text("Elo rating") //change
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
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text("34",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)), //change
                        Text("Tournaments \n played",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 1),
              Container(
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("09",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)), //change
                      Text("Tournaments \n won",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12))
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
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text("26" + "%", //change
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text("Winning \n percentage",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12))
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _tournamentsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _tournamentsList.length - 1) {
                      _fetchMoreTournaments();
                    }

                    var curTournament = _tournamentsList[index];
                    return ReusableListTile(curTournament["game_name"],
                        curTournament["cover_url"], curTournament["name"]);
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
