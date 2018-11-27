
import 'package:random_users_flutter/model/user.dart';

class Item {
  int id;
  String image;
  String title;
  String subtitle;

  Item(this.id, this.image, this.title, { this.subtitle = "No subtitle" });

  factory Item.fromUser(User user) => Item(user.id, user.avatar, user.firstName);
}