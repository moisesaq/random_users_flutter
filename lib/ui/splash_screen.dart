import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_users_flutter/ui/custom_views/button.dart';
import 'package:random_users_flutter/ui/favorites_screen.dart';
import 'package:random_users_flutter/ui/users_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashScreen> {

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return createButtons(context);
  }

  Widget createButtons(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Button(
                    title: "Go to favorites screen",
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
                    }),
                Button(
                    title: "Show alert or dialog",
                    onPressed: () {
                      showAlertDialog(context).then((bool value) {
                        if (value) {
                          showSnackBar(context, textFieldController.text);
                        }
                      });
                    }),
              ],
            )
        ));
  }

  Future<bool> showAlertDialog(BuildContext context) {
    //final textField
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hello flutter"),
            content: TextFormField(
                decoration: createInputDecoration(),
                style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                controller: textFieldController,
                textAlign: TextAlign.end),
            actions: <Widget>[
              Button(
                  title: "Yes",
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
              Button(
                  title: "No",
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  })
            ],
          );
        });
  }

  InputDecoration createInputDecoration() {
    return InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), gapPadding: 20.0),
        filled: true,
        fillColor: Colors.white70,
        hintText: "Numbers");
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message),  duration: Duration(seconds: 3),
        action: SnackBarAction(label: "Ok", onPressed: () {
          print("Ok pressed");
        }));
    _scaffoldState.currentState.showSnackBar(snackBar);
  }


}