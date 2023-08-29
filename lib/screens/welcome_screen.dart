import 'package:flutter/material.dart';
import 'package:tclients/screens/home_screen.dart';
import 'package:tclients/size_config.dart';

import '../components/search_field.dart';
import '../constants.dart';
import '../helpers/storage.dart';
import '../helpers/database.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    TextEditingController passwordController = TextEditingController();

    void pushRoute() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }

    void _incrementCounter() async {
      if (passwordController.text == password) {
        Storage().setToken(passwordController.text);
        await DBHelper().initDB();
        pushRoute();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Açar söz ýalňyş!"),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: elevation,
        title: const Text("HOŞGELDIŇIZ"),
        centerTitle: true,
      ),
      body: Container(
        color: bgColor,
        padding: const EdgeInsets.fromLTRB(margin, 0, margin, 0),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            SearchField(
              icon: Icons.lock,
              hint: 'Açar Söz',
              controller: passwordController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        elevation: elevation,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
