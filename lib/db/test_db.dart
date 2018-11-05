
import 'package:random_users_flutter/db/DAO.dart';
import 'package:random_users_flutter/model/user.dart';

class TestDatabase {

  static void add() async {
    List users;
    var db = await DAO().tableUser;
    await db.saveUser(User(1, "Moi Apaza", "image/moi"));
    await db.saveUser(User(2, "Francesca Apaza", "images/frances"));

    print("----------------- GET ALL USERS --------------");
    users = await db.getAllUsers();
    users.forEach((user) => print(user));
  }

  static void remove() async {
    var db = await DAO().tableUser;
    var result = await db.deleteAll();
    print("Removeds: $result");
    var value = await db.getCount();
    print("Number of users: $value");
  }
}