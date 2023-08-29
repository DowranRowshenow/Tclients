// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// STRINGS
//const String password = "3pVuvFAuFxZ2KVga";
const String password = "2uk92po9vds";
const String appName = "TClients Mobile";
const String appNameUpper = "TCLIENTS MOBILE";
const String numberField = "Telefon Belgisi";
const String nameField = "Familiýasy, Ady we Atasynyň Ady";
const String birthField = "Doglan Wagty we Ýeri";
const String addressField = "Öý Salgysy";
const String passportField = "Passport Belgisi";

// DOUBLES
const double elevation = 1;
const double radius = 3;
const double splashRadius = 24;
const double margin = 20;
const double margin_2 = 15;

// COLORS
const Color bgColor = Color.fromARGB(255, 240, 240, 240);

// ENUMS
enum Orders {
  id,
  number,
  name,
}

extension OrdersName on Orders {
  String get name {
    switch (this) {
      case Orders.id:
        return 'Id';
      case Orders.number:
        return 'Belgisi';
      case Orders.name:
        return 'Ady';
    }
  }
}

extension OrdersValue on Orders {
  String get value {
    switch (this) {
      case Orders.id:
        return 'id';
      case Orders.number:
        return 'number';
      case Orders.name:
        return 'name';
    }
  }
}

// CONTROLLERS
final TextEditingController numberController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController birthController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController passportController = TextEditingController();
