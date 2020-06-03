import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycontacts/Models/ContactModel.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactDetail extends StatefulWidget {
  ContactModel _contactModel;
  ContactDetail(this._contactModel);
  @override
  _ContactDetailState createState() => _ContactDetailState(_contactModel);
}

class _ContactDetailState extends State<ContactDetail> {
  File _image;
  ContactModel _contactinfo;
  _ContactDetailState(this._contactinfo);

  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  bool b = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(_contactinfo.first_name + ' ' + _contactinfo.last_name),
          actions: <Widget>[
            IconButton(
              icon: change_edit(),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (b == false) {
                    b = true;
                  } else {
                    b = false;
                  }
                });
              },
            )
          ],
        ),
        body: _viewer(b));
  }

  Widget change_edit() {
    if (b == false) {
      return Icon(Icons.edit);
    } else {
      return Icon(Icons.done);
    }
  }

  Widget _viewer(bool b) {
    if (b == false) {
      return _viewMode();
    }

    return _editMode();
  }

  Widget _editMode() {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
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
                  onChanged: (value) {
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
            Padding(
              padding: EdgeInsets.all(10.0),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ));
  }

  Widget _viewMode() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Center(
          child: Container(
            child: CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: 'https://picsum.photos/300',
              errorWidget: (context, url, error) => new Icon(Icons.person),
            ),
            color: Colors.cyan[50],
          ),
        ),
        Divider(
          height: 1.0,
          thickness: 5.0,
          color: Colors.cyan,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.cyan,
                size: 20.0,
              ),
              FlatButton(
                color: Colors.white,
                child: Text(_contactinfo.email),
                onPressed: _launchURL,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: EdgeInsets.all(10.0),
        ),
        Divider(
          height: 1.0,
          thickness: 5.0,
          color: Colors.black38,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.phone,
                color: Colors.cyan,
                size: 20.0,
              ),
              FlatButton(
                color: Colors.white,
                child: Text(_contactinfo.phone_no),
                onPressed: _launchURL,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: EdgeInsets.all(10.0),
        ),
        Divider(
          height: 1.0,
          thickness: 5.0,
          color: Colors.black38,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                _contactinfo.gender == 'male'
                    ? Icons.merge_type
                    : Icons.add_circle,
                color: Colors.cyan,
                size: 20.0,
              ),
              FlatButton(
                color: Colors.white,
                child: Text(_contactinfo.gender),
                onPressed: _launchURL,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Divider(
                height: 1.0,
                thickness: 5.0,
                color: Colors.black54,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: EdgeInsets.all(10.0),
        ),
        Divider(
          height: 1.0,
          thickness: 5.0,
          color: Colors.black38,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.calendar_today,
                color: Colors.cyan,
                size: 20.0,
              ),
              FlatButton(
                color: Colors.white,
                child: Text(_contactinfo.date_of_birth),
                onPressed: _launchURL,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Divider(
                height: 1.0,
                thickness: 5.0,
                color: Colors.black54,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: EdgeInsets.all(10.0),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  _launchURL() async {
    var url = 'email:$_contactinfo.email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
