import 'dart:async';
import 'package:random_users_flutter/data/repository/net/parser/user_parser.dart';
import 'package:random_users_flutter/model/user.dart';
import 'package:sqflite/sqflite.dart';

class TableUser {
  static final tableQuery = "SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = 'Users'";
  final Future<Database> _db;

  static const String TABLE_USER = 'Users';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_FIRST_NAME = 'firstName';
  static const String COLUMN_LAST_NAME = 'lastName';
  static const String COLUMN_AVATAR = 'avatar';

  TableUser(this._db);

  Future create() async {
    var db = await _db;
    if (Sqflite.firstIntValue(await db.rawQuery(tableQuery)) == 1) {
      print("Table already exists!");
      return;
    }
    await db.execute("CREATE TABLE $TABLE_USER"
        "($COLUMN_ID INTEGER PRIMARY KEY, "
        " $COLUMN_FIRST_NAME TEXT, "
        " $COLUMN_LAST_NAME TEXT, "
        " $COLUMN_AVATAR)");
    print("Users table created :)");
  }

  Future<bool> existsTable() async {
    var db = await _db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = '$TABLE_USER'")) == 1;
  }

  Future<int> saveUser(User user) async {
    var db = await _db;
    var result = await db.insert(TABLE_USER, UserParser.toMap(user));
    return result;
  }

  Future<List<User>> getAllUsers() async {
    var db = await _db;
    var result = await db.query(TABLE_USER,
        columns: [COLUMN_ID, COLUMN_FIRST_NAME, COLUMN_LAST_NAME, COLUMN_AVATAR]);
    return result.map((obj) {
      return UserParser.fromMap(obj);
    }).toList();
  }

  Future<int> getCount() async {
    var db = await _db;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $TABLE_USER'));
  }

  Future<User> getUser(String id) async {
    var db = await _db;
    List<Map> result = await db.query(TABLE_USER,
        columns: [COLUMN_ID, COLUMN_FIRST_NAME, COLUMN_LAST_NAME, COLUMN_AVATAR],
        where: '$COLUMN_ID = ?', whereArgs: [id]);
    if (result.length > 0) {
      return UserParser.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteUser(int id) async {
    var db = await _db;
    return await db.delete(TABLE_USER, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    var db = await _db;
    return await db.delete(TABLE_USER);
  }

  Future<int> updateUser(User user) async {
    var db = await _db;
    return await db.update(TABLE_USER, UserParser.toMap(user), where: '$COLUMN_ID = ?', whereArgs: [user.id]);
  }
}