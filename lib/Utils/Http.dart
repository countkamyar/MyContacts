import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mycontacts/Models/ContactModel.dart';

Future<List<ContactModel>> fetchContact(int limit) async {
  final response =
      await http.get('https://mock-rest-api-server.herokuapp.com/api/v1/user');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    var jsonData = json.decode(response.body)['data'];
    List<ContactModel> contacts = [];
    for (var c in jsonData) {
      ContactModel contact = ContactModel(
           c["id"],
           c["first_name"],
           c["last_name"],
           c["date_of_birth"],
           c["phone_no"],
           c["email"],
           c["gender"]
           );
      contacts.add(contact);
      if (contacts.length == limit) {
        break;
      }
    
    }
    print(contacts.length);
    return contacts;
    
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load Data');
  }
}
