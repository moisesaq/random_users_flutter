import 'package:random_users_flutter/model/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {

  final ReplaySubject<dynamic> _subject = ReplaySubject<dynamic>();
  Stream<List<User>> _results = Stream.empty();

  UserBloc() {

  }

  void findUsers() {
    //_results =
  }

  void dispose() {
    _subject.close();
  }
}