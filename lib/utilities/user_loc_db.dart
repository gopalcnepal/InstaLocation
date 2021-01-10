import 'dart:async';
import 'package:InstaLocation/models/user_loc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDB() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'user_loc_db.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE locations(id INTEGER PRIMARY KEY AUTOINCREMENT, locDateTime TEXT, userLat DOUBLE, userLon DOUBLE)",
      );
    },
    version: 1,
  );
  return database;
}

Future<void> insertLocation(UserLocation location, final database) async {
  final Database db = await database;

  await db.insert(
    'locations',
    location.toMap(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

Future<List<UserLocation>> locations(final database) async {
  // Get a reference to the database.
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('locations');

  return List.generate(maps.length, (i) {
    return UserLocation(
      id: maps[i]['id'],
      locDateTime: maps[i]['locDateTime'],
      userLat: maps[i]['userLat'],
      userLon: maps[i]['userLon'],
    );
  });
}

Future<void> updateLocation(UserLocation location, final database) async {
  // Get a reference to the database.
  final db = await database;

  await db.update(
    'locations',
    location.toMap(),
    where: "id = ?",
    whereArgs: [location.id],
  );
}

Future<void> deleteLocation(int id, final database) async {
  // Get a reference to the database.
  final db = await database;

  await db.delete(
    'locations',
    where: "id = ?",
    whereArgs: [id],
  );
}

void manipulateDatabase(UserLocation locationObject, final database) async {
  await insertLocation(locationObject, database);
  print(await locations(database));
}
