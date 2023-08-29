import 'package:flutter/material.dart';

import '../components/detail_card.dart';
import '../components/popup_menu.dart';
import '../size_config.dart';
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
        elevation: elevation,
        title: const Text("ABONENT"),
        centerTitle: true,
        leading: const BackIconButton(),
        actions: [
          PopupMenu(user: user),
          SizedBox(width: getProportionateScreenWidth(5)),
        ],
      ),
      body: Container(
        color: bgColor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(margin),
        child: DetailCard(user: user),
      ),
    );
  }
}
