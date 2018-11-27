
import 'package:random_users_flutter/data/repository/db/db_helper.dart';
import 'package:random_users_flutter/data/repository/db/table_users.dart';

class DAO {

  static final DAO _instance = DAO.internal();

  factory DAO() => _instance;

  DBHelper helper;
  TableUser _tableUser;

  DAO.internal() {
    helper = DBHelper();
  }

  Future<TableUser> get tableUser async {
    if(_tableUser == null) {
      _tableUser = await createTableUser();
    }
    return _tableUser;
  }

  Future<TableUser> createTableUser() async {
    var tableUser = TableUser(helper.db);
    await tableUser.create();
    return tableUser;
  }

  void close() {
    helper.close();
  }
}