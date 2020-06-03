import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:mycontacts/Models/ContactModel.dart';
import 'package:mycontacts/Utils/Http.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        defaultBar: AppBar(),
        loader: QuerySetLoader<ContactModel>(
          // querySetCall: ,
          // itemBuilder: _buildItemWidget,
          loadOnEachChange: true,
          animateChanges: true,
        ),
        // onQueryChanged: (query) => _handleQueryChanged(context, query),
        // onQuerySubmitted: (query) => _handleQuerySubmitted(context, query),
      ),
    );
  }

  List<ContactModel> _getItemListForQuery() {
    List<ContactModel> contactModel;
    fetchContact(10).then((onValue) {
      contactModel  = onValue;
       
    });
    print(contactModel);
   return contactModel;
  }
}
