import 'package:flutter/material.dart';

import '../components/back_icon_button.dart';
import '../constants.dart';
import '../components/user_card.dart';
import '../models/user_model.dart';
import '../size_config.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({
    Key? key,
    required this.count,
    required this.users,
  }) : super(key: key);

  final String count;
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: elevation,
        title: const Text("GÖZLEG NETIJESI"),
        centerTitle: true,
        leading: const BackIconButton(),
        actions: [
          Center(child: Text(count, style: const TextStyle(fontSize: 16))),
          SizedBox(width: getProportionateScreenWidth(20)),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(margin, 0, margin, 0),
        color: bgColor,
        child: users == []
            ? const Center(child: Text("Netije Ýok!"))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10)),
                    ...List.generate(users.length, (index) {
                      return UserCard(user: users[index]);
                    }),
                    SizedBox(height: getProportionateScreenHeight(10)),
                  ],
                ),
              ),
      ),
    );
  }
}
