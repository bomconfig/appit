//ปุ๋มถามคอมเฟิรม
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showConfirmLogout(BuildContext context) async {
  SharedPreferences prefe = await SharedPreferences.getInstance();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'ออกจากแอปพลิเคชั่น',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('คุณต้องการออกจากแอปพลิเคชั่น'),
                  Text('ใช่หรือไม่'),
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'ใช่',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              prefe.clear();
              exit(0);
            },
          ),
          TextButton(
            child: const Text(
              'ไม่ใช่',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
