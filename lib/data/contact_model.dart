import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';



class Contact {
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;

  //class constructor below
  Contact({
    required this.name, 
    required this.email, 
    required this.phoneNumber,
    this.isFavorite = false //false
  });

}



class ContactModel extends Model {

  final List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void removeContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }

  void editContact(Contact contact, int contactIndex) {
    _contacts[contactIndex] = contact;
    notifyListeners();
  }

  void changeFavoriteStatus(int index) {
    _contacts[index].isFavorite = true; //!_contacts[index].isFavorite;
    _sortContacts();
    notifyListeners();
  }

  
  //for sorting contacts alphabetically
  void _sortContacts() {
    _contacts.sort((a, b) {
      int comparisonResult;
      //primarily sorting based on whether or not the contact is favorited
      comparisonResult = _compareBasedOnfavoriteStatus(a, b);
      //if the favorite status of two contacts is identical, 
      //secondary, and alphabetical, sorting kicks in
      if(comparisonResult == 0) {
        comparisonResult = _compareAlphabetically(a, b);
      }
      return comparisonResult;
    });
  }
  //compare contact based on selected favorites
  int _compareBasedOnfavoriteStatus(Contact a, Contact b) {
    if (a.isFavorite) {
      //firt contact will be befoe the second contact
      return -1;
    }
    else if (b.isFavorite) {
      return 1;
    }
    else {
      return 0;
    }
  }
  //compare contact alphabetically
  int _compareAlphabetically(Contact a, Contact b) {
    return a.name.compareTo(b.name);
  }
  
}
