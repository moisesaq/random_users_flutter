import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_users_flutter/db/DAO.dart';
import 'package:random_users_flutter/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return UsersPage(title: 'Users');
  }
}

class UsersPage extends StatefulWidget {
  UsersPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  UsersPageState createState() => new UsersPageState();
}

class UsersPageState extends State<UsersPage> {

  final String url = "https://reqres.in/api/users?page=2";
  List data;

  Future<String> doRequest() async {
    final response = await http.get(url);
    setState(() {
      debugPrint(response.body);
      var resBody = json.decode(response.body);
      data = resBody["data"];
      print(data);
    });

    return "Success!";
  }

  @override
  void initState() {
    print(doRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title)
      ),
      body: createList()
    );
  }

  Widget createList() {
    return ListView.builder(
        itemCount: data != null ? data.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return userCardView(index);
        });
  }

  Widget userCardView(int index) {
    return Card(
        child: ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            leading: CircleAvatar(backgroundImage: NetworkImage(data[index]["avatar"])),
            title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${data[index]["first_name"]}", style: TextStyle(fontSize: 17.0))),
            subtitle: Text("${data[index]["last_name"]}"),
            trailing: IconButton(icon: Icon(Icons.favorite), onPressed: () {
              saveAsFavorite(index);
            }))
    );
  }


  void saveAsFavorite(int index) async {
    var id = data[index]["id"];
    var fullname = data[index]["first_name"];
    var image = data[index]["avatar"];
    var db = await DAO().tableUser;
    var result = await db.saveUser(User(id, fullname, image));
    if (result > 1) {
      print("User saved as favorite");
    } else {
      print("Failed!!!");
    }
  }
}

