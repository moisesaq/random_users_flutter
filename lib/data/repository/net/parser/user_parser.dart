
import 'package:random_users_flutter/model/user.dart';

class UserParser {

  static List<User> fromJson(Map json) {
    final data = json['data'];
    return data.map((user) {
      return user;
    }).toList();
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
        id: map[User.ID],
        firstName: map[User.FIRST_NAME],
        lastName: map[User.LAST_NAME],
        avatar: map[User.AVATAR]);
  }

  static Map<String, dynamic> toMap(User user) {
    return {
      User.ID: user.id,
      User.FIRST_NAME: user.firstName,
      User.LAST_NAME: user.lastName,
      User.AVATAR: user.avatar
    };
  }
}