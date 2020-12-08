import 'package:flutter/material.dart';

class ReusableListTile extends StatelessWidget {
  ReusableListTile(this._gameName, this._coverUrl, this._name);
  final String _name;
  final String _gameName;
  final String _coverUrl;

  @override
  Widget build(BuildContext context) {
    Widget cardBody = Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.network(_coverUrl)),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tooltip(
                        message: _name,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 8, 0, 5),
                          child: Text(
                            _name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 6, 0, 5),
                        child: Text(_gameName),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right), onPressed: () {}),
                ),
              )
            ],
          )
        ],
      ),
    );
    return cardBody;
  }
}
