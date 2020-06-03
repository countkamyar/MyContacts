import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _page();
  }

  Widget _page() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('New Contact'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.black,
              onPressed: () {
                setState(() {});
              },
            )
          ],
        ),
        body: _infolist());
  }

  Widget _infolist() {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return ListView(
      children: <Widget>[
        Center(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  child: _image == null
                      ? Text(
                          'No image selected.',
                          style: TextStyle(color: Colors.black38),
                        )
                      : Image.file(_image),
                ),
                Center(
                  child: IconButton(
                    color: Colors.blue,
                    iconSize: 60.0,
                    icon: Icon(Icons.add_a_photo),
                    onPressed: getImage,
                    tooltip: 'Pick Image',
                  ),
                ),
              ],
              alignment: Alignment.center,
            ),
            color: Colors.cyan[50],
          ),
        ),
        Divider(
          height: 1.0,
          thickness: 5.0,
          color: Colors.cyan,
        ),
        //name
        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: TextField(
            style: textStyle,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              debugPrint('Something changed in Title Text Field');
            },
            decoration: InputDecoration(
                labelText: 'Name',
                fillColor: Colors.black38,
                labelStyle: textStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
        ),
//last name
        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: TextField(
            style: textStyle,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              debugPrint('Something changed in Title Text Field');
            },
            decoration: InputDecoration(
                labelText: 'Last Name',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
        ),
//email
        Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              style: textStyle,
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                debugPrint('Something changed in Title Text Field');
              },
              decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.black38,
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            )),
//phone
        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: TextField(
            style: textStyle,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              debugPrint('Something changed in Title Text Field');
            },
            decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: textStyle,
                fillColor: Colors.black38,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 150, right: 150),
          child: RaisedButton(
            child: Text('Add'),
            onPressed: () => {},
            color: Colors.blue,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
        )
      ],
    );
  }
}
