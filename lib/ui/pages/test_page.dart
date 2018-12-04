import 'package:flutter/material.dart';
import 'package:random_users_flutter/ui/custom_views/button.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }

  Widget buildAlertButton() {
    return Button(title: "Show alert or dialog",
        onPressed: () {
          showAlertDialog(context).then((bool value) {
            if (value) {
              showSnackBar(textFieldController.text);
            }
          });
        });
  }

  Future<bool> showAlertDialog(BuildContext context) {
    //final textField
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hello flutter"),
            content: buildTextFormField(textFieldController, buildInputDecoration("Numbers")),
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

  TextFormField buildTextFormField(TextEditingController controller, InputDecoration decoration) {
    return TextFormField(
        decoration: decoration,
        style: TextStyle(color: Colors.blueGrey),
        controller: controller,
        textAlign: TextAlign.start);
  }

  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)), gapPadding: 20.0),
        filled: true,
        fillColor: Colors.white70,
        hintText: hint);
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message),  duration: Duration(seconds: 3),
        action: SnackBarAction(label: "Ok", onPressed: () {
          print("Ok pressed");
        }));
    _scaffoldState.currentState.showSnackBar(snackBar);
  }
}