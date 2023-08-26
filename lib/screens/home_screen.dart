import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tclients/components/user_card.dart';
import 'package:tclients/components/search_field.dart';

import '../../constants.dart';
import '../../helpers/database.dart';
import '../../models/user_model.dart';
import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String count = "0";
  List<User> users = [];
  static const platform = MethodChannel('samples.flutter.dev/battery');

  @override
  void initState() async {
    super.initState();
    print("Requesting");
    await _listenCalls();
  }

  bool isNumeric(String str) {
    // ignore: no_leading_underscores_for_local_identifiers
    RegExp _numeric = RegExp(r'^[0-9]+$');
    return _numeric.hasMatch(str);
  }

  void _incrementCounter() async {
    if (isNumeric(searchController.text)) {
      final map = await DBHelper().searhByPhone(searchController.text);
      count = "${map["count"]}";
      users = map["users"];
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Dogry maglumat giriz!"),
      ));
    }
  }

  Future<void> _listenCalls() async {
    try {
      final result = await platform.invokeMethod('listenCalls');
      print("Finished: $result");
    } on PlatformException catch (e) {
      print("Failed: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(appNameUpper),
        centerTitle: true,
        elevation: 0,
        actions: [
          count != "0"
              ? Center(child: Text(count, style: const TextStyle(fontSize: 16)))
              : Container(),
          SizedBox(width: getProportionateScreenWidth(20))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: const SearchField(),
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 240, 240, 240),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(margin, 0, margin, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(10)),
              /*
              Row(
                children: [
                  Text(
                    " Jemi: $count",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              */
              ...List.generate(users.length, (index) {
                return UserCard(user: users[index]);
              }),
              SizedBox(height: getProportionateScreenHeight(20))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
