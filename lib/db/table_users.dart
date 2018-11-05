import 'dart:async';
import 'package:random_users_flutter/model/user.dart';
import 'package:sqflite/sqflite.dart';

class TableUser {
  static final tableQuery = "SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = 'Users'";
  final Future<Database> _db;

  final String tableUser = 'Users';
  final String columnId = 'id';
  final String columnFullname = 'fullname';
  final String columnImage = 'image';

  TableUser(this._db);

  Future create() async {
    var db = await _db;
    if (Sqflite.firstIntValue(await db.rawQuery(tableQuery)) == 1) {
      print("Table already exists!");
      return;
    }
    await db.execute("CREATE TABLE Users(id INTEGER PRIMARY KEY, fullname TEXT, image TEXT)");
    print("Users table created :)");
  }

  Future<bool> existsTable() async {
    var db = await _db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = 'Users'")) == 1;
  }

  Future<int> saveUser(User user) async {
    var db = await _db;
    var result = await db.insert(tableUser, user.toMap());
    return result;
  }

  Future<List<User>> getAllUsers() async {
    var db = await _db;
    var result = await db.query(tableUser, columns: [columnId, columnFullname, columnImage]);
    return result.map((obj) {
      return User.map(obj);
    }).toList();
  }

  Future<int> getCount() async {
    var db = await _db;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableUser'));
  }

  Future<User> getUser(String id) async {
    var db = await _db;
    List<Map> result = await db.query(tableUser, columns: [columnId, columnFullname, columnImage], where: '$columnId = ?', whereArgs: [id]);
    if (result.length > 0) {
      return User.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteUser(int id) async {
    var db = await _db;
    return await db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    var db = await _db;
    return await db.delete(tableUser);
  }

  Future<int> updateUser(User user) async {
    var db = await _db;
    return await db.update(tableUser, user.toMap(), where: '$columnId = ?', whereArgs: [user.id]);
  }
}