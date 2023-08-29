import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'helpers/storage.dart';
import 'components/scroll_behavior.dart';
import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';

String token = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await Storage().loadToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: appName,
      theme: ThemeData(),
      //darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: token == password ? const HomeScreen() : const WelcomeScreen(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: GlowlessScrollBehavior(),
          child: child!,
        );
      },
    );
  }
}
