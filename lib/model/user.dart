
import 'package:random_users_flutter/model/Item.dart';

class User {
  int _id;
  String _fullname;
  String _image;

  User(this._id, this._fullname, this._image);

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._fullname = obj['fullname'];
    this._image = obj['image'];
  }

  int get id => _id;
  String get fullname => _fullname;
  String get image => _image;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['fullname'] = _fullname;
    map['image'] = _image;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._fullname = map['fullname'];
    this._image = map['image'];
  }

  Item toItem() {
    return Item(_id, _image, _fullname);
  }
}