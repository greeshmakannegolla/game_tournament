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
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(_gameName)
                    ],
                  ),
                ),
              ),
              Spacer(),
              Flexible(
                child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right), onPressed: () {}),
              )
            ],
          )
        ],
      ),
    );
    return cardBody;
  }
}
