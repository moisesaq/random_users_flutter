import 'package:meta/meta.dart';

class User {
  static const ID = 'id';
  static const FIRST_NAME = 'firstName';
  static const LAST_NAME = 'lastName';
  static const AVATAR = 'avatar';
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;

  User(
      { @required this.id,
        @required this.firstName,
        this.lastName, this.avatar});
}