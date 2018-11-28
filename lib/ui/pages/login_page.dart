import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_users_flutter/ui/custom_views/button.dart';
import 'package:random_users_flutter/ui/pages/favorites_page.dart';
import 'package:random_users_flutter/ui/pages/users_page.dart';
import 'package:random_users_flutter/ui/utils/validate_login_fields.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final textFieldController = TextEditingController();

  TextFormField emailTextForm;
  TextFormField passwordTextForm;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return createButtons(context);
  }

  Widget createButtons(BuildContext context) {
    emailTextForm = buildTextFormField(emailController, buildInputDecoration("Email"));
    passwordTextForm = buildTextFormField(passwordController, buildInputDecoration("Password"));
    return Scaffold(
        key: _scaffoldState,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(child: emailTextForm , padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                Padding(child: passwordTextForm , padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
                Button(
                    title: "Login",
                    onPressed: () => validateLogin()),
              ],
            )
        ));
  }

  void validateLogin() {
    final validation = ValidateLoginFields.validateEmail(emailController.text);
    if (validation != null) {
      showSnackBar(validation);
      return;
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FavoritesPage()));
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