import 'package:flutter/material.dart';
import 'package:tclients/components/popup_menu.dart';
import 'package:tclients/components/property_card.dart';
import 'package:tclients/size_config.dart';

import '../components/back_icon_button.dart';
import '../constants.dart';
import '../models/user_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("ABONENT"),
        centerTitle: true,
        leading: const BackIconButton(),
        actions: [
          PopupMenu(user: user),
          SizedBox(width: getProportionateScreenWidth(5)),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 240, 240, 240),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(margin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PropertyCard(
              property: "Telefon Belgisi",
              value: "+${user.number}",
            ),
            PropertyCard(
              property: "Familiýasy, ady we atasynyň ady",
              value: user.name,
            ),
            PropertyCard(
              property: "Doglan senesi we ýeri",
              value: user.birth,
            ),
            PropertyCard(
              property: "Öý Salgysy",
              value: user.address,
            ),
            PropertyCard(
              property: "Passport Belgisi",
              value: user.passport,
            ),
          ],
        ),
      ),
    );
  }
}
