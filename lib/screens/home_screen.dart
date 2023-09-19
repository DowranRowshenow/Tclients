import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'filter_screen.dart';
import '../components/detail_card.dart';
import '../components/search_field.dart';
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
  User user = User.defaultUser();
  static const platform = MethodChannel('samples.flutter.dev/battery');

  @override
  void initState() {
    super.initState();
    print("Initializing Listener Service");
    initListener();
    print("Initializing Listener Service Complete");
  }

  void initListener() async {
    await _listenCalls();
  }

  bool isNumeric(String str) {
    // ignore: no_leading_underscores_for_local_identifiers
    RegExp _numeric = RegExp(r'^[0-9]+$');
    return _numeric.hasMatch(str);
  }

  void _incrementCounter() async {
    if (isNumeric(numberController.text)) {
      user = await DBHelper().getUser(numberController.text);
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
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Çykmak isleýärsiňizmi?"),
              actions: [
                TextButton(
                  child: const Text("Hawa"),
                  onPressed: () {
                    exit(0);
                  },
                ),
                TextButton(
                  child: const Text("Ýok"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text(appNameUpper),
          centerTitle: true,
          elevation: elevation,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FilterScreen()),
                );
              },
              icon: const Icon(Icons.sort),
              splashRadius: splashRadius,
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: SearchField(
                height: 50,
                length: 11,
                type: TextInputType.phone,
                hint: "Telefon Belgisi",
                controller: numberController,
              ),
            ),
          ),
        ),
        body: Container(
          color: bgColor,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(margin, 0, margin, 0),
          child: user.name != "name"
              ? SingleChildScrollView(child: DetailCard(user: user))
              : const Center(child: Text("GÖZLEGE BAŞLA")),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          elevation: elevation,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
