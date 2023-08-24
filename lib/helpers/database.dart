// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:tclients/helpers/extraction.dart';
import 'package:tclients/models/user_model.dart';

//const path = '/storage/emulated/0/Tclients/clients.db';

class DBHelper {
  Future<void> initDB() async {
    print("Initializing Database");
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'clients.db');

    final exist = await databaseExists(path);

    if (!exist) {
      await ExtHelper().extractZip();
    }

    try {
      await openDatabase(path, version: 1);
      //final map = await db.rawQuery("SELECT COUNT(*) FROM user");
      //print("Database Init with ${Sqflite.firstIntValue(map)}");
    } catch (e) {
      print(e);
    }
    print("Initializing Complete");
  }

  Future<User> raw(String raw) async {
    print("Get Raw");
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'clients.db');
    // Get a reference to the database.
    final db = await openDatabase(path, version: 1);

    // Query the table for all The Users.
    try {
      final List<Map<String, dynamic>> maps = await db.rawQuery(raw);
      print("Get Raw Complete");
      // Convert the List<Map<String, dynamic> into a User.
      return User(
        id: maps[0]['id'],
        name: maps[0]['name'],
        number: maps[0]['number'],
        birth: maps[0]['birth'],
        address: maps[0]['address'],
        passport: maps[0]['passport'],
      );
    } catch (e) {
      print('ERROR: $e');
      return User.defaultUser();
    }
  }

  Future<Map<String, dynamic>> searhByPhone(String number) async {
    print("Searching Users By Phone");
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'clients.db');
    // Get a reference to the database.
    final db = await openDatabase(path, version: 1);

    // Query the count for the Users.
    final map = await db
        .rawQuery("SELECT COUNT(*) FROM user WHERE number LIKE '%$number%'");
    final count = Sqflite.firstIntValue(map);

    // Query the table for all the Users.
    final List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM user WHERE number LIKE '%$number%' LIMIT 100");

    // Convert the List<Map<String, dynamic> into a List<User>.
    List<User> users = maps.map((user) => User.toUser(user)).toList();
    print("Searching By Phone Complete With $count Result");
    return {"count": count, "users": users};
  }
}
