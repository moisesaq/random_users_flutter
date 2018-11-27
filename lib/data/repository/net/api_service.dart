import 'dart:async';
import 'dart:convert';
import 'package:random_users_flutter/data/repository/net/api.dart';
import 'package:random_users_flutter/data/repository/net/parser/user_parser.dart';
import 'package:random_users_flutter/model/user.dart';
import 'package:http/http.dart' as http;

class ApiService {

  Future<List<User>> getUsers() async {
    final response = await http.get(Api.URL_GET_USERS);
    List<User> users = UserParser.fromJson(json.decode(response.body));
    return users;
  }
}