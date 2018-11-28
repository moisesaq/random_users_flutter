// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_users_flutter/ui/app.dart';
import 'package:random_users_flutter/ui/utils/validate_login_fields.dart';

void main() {
  test('Empty Email Test', () {
    var result = ValidateLoginFields.validateEmail('');
    expect(result, 'Enter email!');
  });

  test('Invalid Email Test', () {
    var result = ValidateLoginFields.validateEmail('moisesapaza');
    expect(result, 'Enter Valid Email!');
  });

  test('Valid Email Test', () {
    var result = ValidateLoginFields.validateEmail('moisesapaza07@gmail.com');
    expect(result, null);
  });

  test('Empty Password Test', () {
    var result = ValidateLoginFields.validatePassword('');
    expect(result, 'Enter password!');
  });

  test('Invalid Password Test', () {
    var result = ValidateLoginFields.validatePassword('123');
    expect(result, 'Password must ve more than 6 character');
  });

  test('Valid Password Test', () {
    var result = ValidateLoginFields.validatePassword('qweqwe12313');
    expect(result, null);
  });
}
