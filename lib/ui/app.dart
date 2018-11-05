import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_users_flutter/ui/splash_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen()//new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}