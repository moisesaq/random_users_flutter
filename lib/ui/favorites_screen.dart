import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_users_flutter/db/test_db.dart';
import 'package:random_users_flutter/db/dao.dart';
import 'package:random_users_flutter/model/Item.dart';
import 'package:random_users_flutter/ui/custom_views/button.dart';
import 'package:random_users_flutter/model/user.dart';
import 'package:random_users_flutter/ui/custom_views/item_selection/item_selection.dart';
import 'package:random_users_flutter/ui/users_screen.dart';
import 'package:random_users_flutter/ui/utils/status_item_selection.dart';


class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  FavoriteUsersPage();
  }

  //Just for test
  Widget createButton() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Button(
              title: "Test database",
              onPressed: () {
                TestDatabase.add();
              }),
          Button(
              title: "Remove db",
              onPressed: () {
                TestDatabase.remove();
              })
        ],
      ),
    );
  }
}

class FavoriteUsersPage extends StatefulWidget {

  @override
  FavoriteUsersState createState() => FavoriteUsersState();
}

class FavoriteUsersState extends State<FavoriteUsersPage> {

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  List<User> users;
  ItemSelection itemSelection;

  final statusNotifier = ValueNotifier(StatusItemSelection.LOADING);
  final StreamController<List<Item>> _streamItems = StreamController<List<Item>>();

  Future<String> loadDatabase() async {
    var db = await DAO().tableUser;
    var result = await db.getAllUsers();
    List<Item> items = result.map((user) => user.toItem()).toList();
    _streamItems.sink.add(items);
    if (items.isEmpty) {
      statusNotifier.value = StatusItemSelection.EMPTY;
    } else {
      statusNotifier.value = StatusItemSelection.LIST;
    }
    return "Success!";
  }

  @override
  void initState() {
    print(loadDatabase());
    super.initState();
  }

  @override
  void dispose() {
    _streamItems.close();
    statusNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldState,
        appBar: new AppBar(
          title: new Text("Favorite Users"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersScreen()));
            }),
            IconButton(icon: Icon(Icons.dashboard), onPressed: () {
              changeStatusView();
            })
          ]
        ),
        body: ItemSelection(statusListenable: statusNotifier, streamItems: _streamItems, didItemSelected: (Item item) {
          print("Item selected ${item.title}");
          showSnackBar(context, item.title);
        })
    );
  }

  void changeStatusView() {
    var value = statusNotifier.value;
    if (value == StatusItemSelection.LIST) {
      statusNotifier.value = StatusItemSelection.PAGE;
    } else {
      statusNotifier.value = StatusItemSelection.LIST;
    }
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message),  duration: Duration(seconds: 1),
        action: SnackBarAction(label: "Ok", onPressed: () {
          print("Ok pressed");
        }));
    _scaffoldState.currentState.showSnackBar(snackBar);
  }

  void removeFromFavorites(int index) async {
    var db = await DAO().tableUser;
    var result = await db.deleteUser(users[index].id);
    if (result > 0) {
      setState(() {
        users.removeAt(index);
      });
    }
    print("Removed!!");
  }
}