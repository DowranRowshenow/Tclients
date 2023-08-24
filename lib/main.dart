import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/scroll_behavior.dart';
import 'helpers/database.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initDB();
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
      title: 'TClients Mobile',
      theme: ThemeData(),
      //darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: GlowlessScrollBehavior(),
          child: child!,
        );
      },
    );
  }
}
