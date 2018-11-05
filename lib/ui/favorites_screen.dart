import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_users_flutter/db/test_db.dart';
import 'package:random_users_flutter/db/dao.dart';
import 'package:random_users_flutter/model/Item.dart';
import 'package:random_users_flutter/ui/custom_views/button.dart';
import 'package:random_users_flutter/model/user.dart';
import 'package:random_users_flutter/ui/item_selection.dart';
import 'package:random_users_flutter/ui/users_screen.dart';


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

  bool showList = false;
  bool loading = false;
  List<User> users;
  ItemSelection itemSelection;

  final modeNotifier = ValueNotifier(0);
  final StreamController<List<Item>> _streamItems = StreamController<List<Item>>();

  Future<String> loadDatabase() async {
    var db = await DAO().tableUser;
    var result = await db.getAllUsers();
    List<Item> items = result.map((user) => user.toItem()).toList();
    modeNotifier.value = 1;
    _streamItems.sink.add(items);
    return "Success!";
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    print(loadDatabase());
    super.initState();
  }

  @override
  void dispose() {
    _streamItems.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Favorite Users"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersScreen()));
            }),
            IconButton(icon: Icon(Icons.dashboard), onPressed: () {
              var value = modeNotifier.value;
              print(value);
              modeNotifier.value = 2;
            })
          ]
        ),
        body: ItemSelection(modeListenable: modeNotifier, streamItems: _streamItems, didItemSelected: (Item item) {
          print("Item selected ${item.title}");
        })//getBody()
    );
  }

  Widget getBody() {
    return showList ? Center(child: SizedBox(height: 320.0, child: favoriteList())) : Center(child: Text("Hello world"));
  }

  Widget favoriteList() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users != null ? users.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return userCardView(index);
        });
  }

  Widget userCardView(int index) {
    return Card(color: Colors.white70,
        child: userHorizontalView(index));
  }

  Widget userHorizontalView(int index) {
    return SizedBox(width: 320.0, height: 200.0,
        child: Column(children: <Widget>[
          CircleAvatar(backgroundImage: NetworkImage(users[index].image, scale: 3.0), radius: 100.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                title(index),
                IconButton(icon: Icon(Icons.delete), onPressed: () {
                  removeFromFavorites(index);
                })
              ]
          )],
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center));
  }

  Widget title(int index) {
    return Padding(padding: const EdgeInsets.all(8.0), 
        child: Text("${users[index].fullname}", style: TextStyle(fontSize: 30.0)));
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