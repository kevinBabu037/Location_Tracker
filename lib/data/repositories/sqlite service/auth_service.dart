import 'dart:developer';

import 'package:location_tracker/data/model/location.dart';
import 'package:location_tracker/data/model/user.dart';
import 'package:location_tracker/data/secure_storage/secure_storage.dart';
import 'package:location_tracker/data/shared_pref/shared_pref.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService {
  static final SqfliteService _instance = SqfliteService._internal();
  Database? _db;

  SecureStorage storage = SecureStorage();

  factory SqfliteService() {
    return _instance;
  }

  SqfliteService._internal();

  Future<void> initializeDatabase() async {
    if (_db != null) return;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      version: 2, // Updated version to trigger onUpgrade
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT UNIQUE, name TEXT, password TEXT)",
        );
        await db.execute(
          "CREATE TABLE location_data (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, latitude REAL, longitude REAL, timestamp TEXT)",
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            "CREATE TABLE IF NOT EXISTS location_data (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, latitude REAL, longitude REAL, timestamp TEXT)",
          );
        }
      },
    ); 
  }

  Future<Database> _getDb() async {
    if (_db == null) {
      await initializeDatabase();
    }
    return _db!;
  }

  Future<int> addUser(UserModel user) async {
    final db = await _getDb();
    final int result = await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (result != 0) {
      await SharedPreferenses.saveBoolValue(true);
      await storage.writeSecureData('userId', result.toString());
    }
    return result;
  }

  Future<UserModel?> loginUser(String email, String password) async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
     await SharedPreferenses.saveBoolValue(true);
      UserModel user = UserModel.fromMap(maps.first);
      await storage.writeSecureData('userId', user.id.toString());
      return user;
    } else {
      return null;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query('user');
    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]);
    });
  }

  Future<int> deleteUser(int id) async {
    final db = await _getDb();
    return await db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<int> storeLocationData(LocationData locationData) async {
  final db = await _getDb();
  final Map<String, dynamic> dataToInsert = {
    'userId': locationData.userId,
    'latitude': locationData.latitude,
    'longitude': locationData.longitude,
    'timestamp': locationData.timestamp,
  };

  log('Storing location data: $dataToInsert');
  final int result = await db.insert(
    'location_data',
    dataToInsert,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  log('Location data stored with id: $result');
  return result;
}


  Future<List<LocationData>> getLocationHistory(int userId) async {
  final db = await _getDb();
  log('Querying location data for userId: $userId');
  final List<Map<String, dynamic>> maps = await db.query(
    'location_data',
    where: 'userId = ?',
    whereArgs: [userId],
  );
  log('Location data query result: $maps');
  return List.generate(maps.length, (i) {
    return LocationData.fromMap(maps[i]);
  });
 }





}
