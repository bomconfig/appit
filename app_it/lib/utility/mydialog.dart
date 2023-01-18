import 'package:flutter/material.dart';

import '../widget/show_image.dart';
import '../widget/show_title.dart';
import 'myconstan.dart';

class MyDialog {
  final Function()? funcAction;

  MyDialog({this.funcAction});

  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImagePage(path: MyConstant.logo1),
          title: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
          subtitle:
              ShowTitle(title: message, textStyle: MyConstant().h3Style()),
        ),
        children: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }

  Future<Null> normalDialog2(BuildContext context, String title) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImagePage(path: MyConstant.logo1),
          title: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
        ),
        children: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }
}
