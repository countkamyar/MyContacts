import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mycontacts/ContactDetails.dart';
import 'package:mycontacts/Models/ContactModel.dart';
import 'package:mycontacts/SearchPage.dart';
import 'package:mycontacts/Utils/Http.dart';
import 'package:page_transition/page_transition.dart';

import './AddContact.dart';

class AllContacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AllContactsState(contactModel: fetchContact(50));
  }
}

// Future<bool> check_connectivity() async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       return true;
//     }
//   } on SocketException catch (_) {
//     return false;
//   }
// }
//   Future<List<ContactModel>> getlist() async {
//     final List<ContactModel> contactList = await fetchContact();
//     return contactList;
//   }
class _AllContactsState extends State<AllContacts> {
  final Future<List<ContactModel>> contactModel;
  _AllContactsState({Key key, this.contactModel});

  bool _firstRun = true;
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: AppBar(
            centerTitle: true,
            title: FlatButton(
              child: Text(
                'Search Contacts',
                style: TextStyle(
                    color: Colors.cyan,
                    textBaseline: TextBaseline.ideographic,
                    fontSize: 18),
              ),
              onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.upToDown, child: SearchPage())),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.update),
                  iconSize: 28,
                  color: Colors.cyan,
                  onPressed: () {
                    setState(() {
                      _getcontactList();
                    });
                  })
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              _getcontactList(),
              Container(
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blueAccent,
                  onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: AddContact()),
                  ),
                ),
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget _buildItemWidget(ContactModel contact) {
    return Card(
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 8.0, 
            runSpacing: 4.0, 
            direction: Axis.horizontal,
            children: <Widget>[
              Container(
                child: CachedNetworkImage(fadeOutCurve: Curves.easeIn,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: 'https://picsum.photos/50',
                  errorWidget: (context, url, error) => new Icon(Icons.person),
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                color: Colors.cyan[300],
              ),
              Text(
                contact.first_name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                contact.last_name,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Padding( padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                icon: Icon(Icons.star),
                color: Colors.amberAccent,
                iconSize: 10.0,
                onPressed: () {},
              )),
              Padding(padding: EdgeInsets.all(5.0)),
            ],
          ),
          //second row
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  contact.email,
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.only(left: 10),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      margin: EdgeInsets.all(1),
    );
  }

  Widget _getcontactList() {
    return Container(
      child: FutureBuilder<List<ContactModel>>(
          future: contactModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _slidableBuild(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
    );
  }

  Widget _buildContactList(List<ContactModel> list, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: 'https://picsum.photos/90',
                  errorWidget: (context, url, error) => new Icon(Icons.person),
                ),
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.all(10.0),
              ),
              Text(
                list[index].first_name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                list[index].last_name,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Center(
                  child: IconButton(
                icon: Icon(Icons.star),
                color: Colors.amberAccent,
                iconSize: 36.0,
                onPressed: () {
                  _displaySnackBar(context, 'Added to the favorites');
                },
              )),
              Padding(padding: EdgeInsets.all(10.0)),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          //second row
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  list[index].email,
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.only(left: 10),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      margin: EdgeInsets.all(1),
    );
  }

  Widget _slidableBuild(List<ContactModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Builder(
            builder: (context) => GestureDetector(
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: _buildContactList(list, index),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Archive',
                        color: Colors.blue,
                        icon: Icons.archive,
                        onTap: () =>
                            _displaySnackBar(context, '$index Archived'),
                      ),
                      IconSlideAction(
                        caption: 'Share',
                        color: Colors.indigo,
                        icon: Icons.share,
                        onTap: () => _displaySnackBar(context, '$index Shared'),
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'More',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () => _displaySnackBar(context, '$index More'),
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () =>
                            _displaySnackBar(context, '$index Item Deleted'),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: ContactDetail(list[index]))),
                ));
      },
    );
  }

  Widget _appBarState(bool state) {
    if (state) {
      return TextField(
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.search,
        style: TextStyle(color: Colors.blue),
      );
    } else {
      return Text(
        'Search Contacts',
      );
    }
  }

  void _displaySnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.blue[300],
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
