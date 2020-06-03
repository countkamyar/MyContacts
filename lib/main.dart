import 'package:flutter/material.dart';
import 'package:mycontacts/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyContacts',
      home: HomePage(),
      theme: ThemeData(
          brightness: Brightness.light,
          cardColor: Colors.blueGrey,
          primaryColor: Colors.white,
          accentColor: Colors.cyan[300],
          buttonColor: Colors.black87),
    );
  }
  
}
  