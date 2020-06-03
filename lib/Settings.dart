import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.expand_more,
                color: Colors.cyan,
              ),
              onPressed: () => {},
            )
          ],
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('https://picsum.photos/90')),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Kamyar Rostami',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Divider(
          color: Colors.blue,
          thickness: 5,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Tap to sync contacts: ',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          child: FlatButton.icon(
            icon: Icon(
              Icons.sync,
              color: Colors.white,
            ),
            label: Text(
              'Sync',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: () => {},
          ),
          margin: EdgeInsets.only(top: 20),
        ),
        Divider(
          color: Colors.blue,
          thickness: 5,
        ),
      ],
    );
  }
}
