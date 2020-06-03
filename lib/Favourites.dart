import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mycontacts/ContactDetails.dart';
import 'package:mycontacts/FavouritesList.dart';
import 'package:mycontacts/Models/ContactModel.dart';
import 'package:mycontacts/Utils/Http.dart';
import 'package:page_transition/page_transition.dart';

class Favourites extends StatefulWidget {
  @override
  _SliverExampleState createState() =>
      _SliverExampleState(contactModel: fetchContact(10));
}

class _SliverExampleState extends State<Favourites> {
  final Future<List<ContactModel>> contactModel;
  _SliverExampleState({Key key, this.contactModel});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _getcontactList(),
      ),
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
