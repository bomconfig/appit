import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> showLogout(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? id = prefs.remove('id');
  Object? type = prefs.remove('type');
  Object? name = prefs.remove('name');
  Navigator.pushReplacementNamed(context, '/login');
}
